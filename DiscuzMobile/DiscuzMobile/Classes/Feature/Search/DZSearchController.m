//
//  DZSearchController.m
//  DiscuzMobile
//
//  Created by HB on 16/4/15.
//  Copyright © 2016年 comsenz-service.com. All rights reserved.
//

#import "DZSearchController.h"
#import "DZSearchHistoryController.h"

#import "DZSearchModel.h"
#import "DZForumThreadController.h"
#import "DZSearchListCell.h"
#import "DZCustomSearchBarView.h"
#import "UIAlertController+Extension.h"

@interface DZSearchController ()<UISearchBarDelegate>

@property (nonatomic, strong) DZCustomSearchBarView *searchView;
@property (nonatomic, strong) DZSearchHistoryController *historyVC;

@end

@implementation DZSearchController

- (instancetype)init
{
    self = [super init];
    if (self) { // 设置默认
        self.type = searchPostionTypeNext;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
    [self.view addSubview:self.tableView];
    if (self.type == searchPostionTypeNext) {
        [self.searchView.searchBar becomeFirstResponder];
    }
    
    KWEAKSELF;
    self.historyVC.SearchClick = ^(NSString *searchText) {
        weakSelf.searchView.searchBar.text = searchText;
        [weakSelf searchBarEndActive];
        [weakSelf clickSearch:searchText];
    };
    
    self.historyVC.ScrollWillDrag = ^{
        [weakSelf searchBarEndActive];
    };
}

#pragma mark - 布局
- (void)setupViews {

    [self configNaviBar:@"" type:NaviItemText Direction:NaviDirectionLeft];
    [self.navigationItem setHidesBackButton:YES];
    
    self.searchView = [[DZCustomSearchBarView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 30)];
    self.searchView.searchBar.delegate = self;
    self.navigationItem.titleView = self.searchView;
    [self.searchView.cancelBtn addTarget:self action:@selector(rightBarBtnClick) forControlEvents:UIControlEventTouchUpInside];
    if (self.type == searchPostionTypeTabbar) {
        self.searchView.searchBar.frame = CGRectMake(5, 1, KScreenWidth - 30, 28);
        [self.searchView.cancelBtn setHidden:YES];
    }
    
    
    [self.tableView registerClass:[DZSearchListCell class] forCellReuseIdentifier:[DZSearchListCell getReuseId]];
    self.tableView.backgroundColor = [UIColor whiteColor];
    KWEAKSELF
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.page ++;
        [weakSelf requestData];
    }];
    self.tableView.mj_footer.hidden = YES;
    
}

- (void)rightBarBtnClick {
    [self.searchView.searchBar resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)leftBarBtnClick{}


#pragma mark - UITableDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DZSearchListCell *cell = [tableView dequeueReusableCellWithIdentifier:[DZSearchListCell getReuseId]];
    DZSearchModel *model = self.dataSourceArr[indexPath.row];
    cell.info = model;
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.dataSourceArr.count > 0) {
        DZSearchModel *model = self.dataSourceArr[indexPath.row];
        DZForumThreadController * tvc = [[DZForumThreadController alloc] init];
        tvc.tid = model.tid;
        tvc.threadtitle = model.subject;
        [self.navigationController pushViewController:tvc animated:YES];
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, KScreenWidth - 20, 39)];
    lab.textColor = [UIColor darkGrayColor];
    lab.font = [UIFont systemFontOfSize:14.0];
    lab.textAlignment = NSTextAlignmentLeft;
    UIView *lineView  = [[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(lab.frame), KScreenWidth - 15, 0.5)];
    lineView.backgroundColor = [UIColor lightGrayColor]; 
    if (section == 0) {
        lab.text = @"相关帖子";
    } else {
        lab.text = @"";
    }
    [view addSubview:lab];
    [view addSubview:lineView];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.cellHeightDict[indexPath]) {
        self.cellHeightDict[indexPath] = @([self caculateCellHeight:indexPath]);
    }
    return [self.cellHeightDict[indexPath] floatValue];
}

- (CGFloat)caculateCellHeight:(NSIndexPath *)indexPath {
    DZSearchModel *model = self.dataSourceArr[indexPath.row];
    DZSearchListCell *cell = [self.tableView dequeueReusableCellWithIdentifier:[DZSearchListCell getReuseId]];
    return [cell caculateCellHeight:model];
}

// 右Button响应
- (void)rightBarButtonItemAction:(UIBarButtonItem *)sender {
    [self.searchView.searchBar resignFirstResponder];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

#pragma mark - UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    return YES;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
}

#pragma mark - 搜索响应事件
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self searchBarEndActive];
    if (![DataCheck isValidString:searchBar.text]) {
        [UIAlertController alertTitle:@"提示" message:@"请输入关键字" controller:self doneText:@"确定" cancelText:nil doneHandle:nil cancelHandle:nil];
        return;
    }
    
    NSString *searchText = searchBar.text;
    [self clickSearch:searchText];
}

- (void)clickSearch:(NSString *)searchText {
    self.historyVC.view.hidden = YES;
    [self.historyVC saveSearchHistory:searchText];
    self.historyVC.view.hidden = YES;
    
    if (self.dataSourceArr.count > 0) {
        self.dataSourceArr = [NSMutableArray array];
        [self.cellHeightDict removeAllObjects];
    }
    [self.tableView reloadData];
    self.tableView.mj_footer.hidden = YES;
    self.tableView.contentOffset = CGPointZero;
    self.page = 1;
    [self requestData];
}


- (void)requestData {
    if (![DataCheck isValidArray:self.dataSourceArr]) {
        [self.HUD showLoadingMessag:@"搜索中" toView:self.view];
    }
    [DZApiRequest requestWithConfig:^(JTURLRequest *request) {
        NSDictionary *dic = @{@"srchtxt":self.searchView.searchBar.text,
                              @"page":[NSString stringWithFormat:@"%ld",self.page],
                              };
        request.urlString = DZ_Url_Search;
        request.parameters = dic;
    } success:^(id responseObject, JTLoadType type) {
        [self.HUD hide];
        [self.tableView.mj_footer endRefreshing];
        
        if ([DataCheck isValidDictionary:[responseObject objectForKey:@"Variables"]]) {
            
            if ([DataCheck isValidArray: [[responseObject objectForKey:@"Variables"] objectForKey:@"threadlist"]]) {
                NSArray *dataArr = [[responseObject objectForKey:@"Variables"] objectForKey:@"threadlist"];
                for (NSDictionary *dic in dataArr) {
                    
                    DZSearchModel *model = [[DZSearchModel alloc] init];
                    [model setValuesForKeysWithDictionary:dic];
                    model.keyword = self.searchView.searchBar.text;
                    [self.dataSourceArr addObject:model];
                    
                }
                NSInteger total = [[[responseObject objectForKey:@"Variables"] objectForKey:@"total"] integerValue];
                if (self.dataSourceArr.count >= total) {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }
            }
        } else {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            self.page --;
        }
        [self emptyShow];
        if (self.dataSourceArr.count == 0) {
            [self searchBarBecomeActive];
        }
        
        [self.tableView reloadData];
    } failed:^(NSError *error) {
        [self.HUD hide];
        [self searchBarBecomeActive];
    }];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.searchView.searchBar endEditing:YES];
}

- (void)searchBarBecomeActive {
    [self.searchView.searchBar becomeFirstResponder];
}
- (void)searchBarEndActive {
    [self.searchView.searchBar endEditing:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self searchBarEndActive];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (![DataCheck isValidString:searchText]) {
        self.historyVC.view.hidden = NO;
        if (self.dataSourceArr.count > 0) {
            self.dataSourceArr = [NSMutableArray array];
            self.tableView.mj_footer.hidden = YES;
            [self.cellHeightDict removeAllObjects];
            [self.tableView reloadData];
        }
    }
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    
}

- (DZSearchHistoryController *)historyVC {
    if (_historyVC == nil) {
        _historyVC = [[DZSearchHistoryController alloc] init];
        [self.view addSubview:_historyVC.view];
        [self addChildViewController:_historyVC];
    }
    return _historyVC;
}

@end
