//
//  DZForumListTableView.m
//  PandaReader
//
//  Created by WebersonGao on 2018/10/22.
//

#import "DZForumListTableView.h"
#import "DZForumListTableCell.h"

@interface DZForumListTableView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) MJRefreshFooter *refreshFooterView;

@end

@implementation DZForumListTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
#ifdef __IPHONE_11_0
        if (@available(iOS 11.0, *)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
#endif
        self.backgroundColor = KColor(@"#F6F7F8", 1.0);
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.estimatedRowHeight = 0;
        self.estimatedSectionFooterHeight = 0;
        self.estimatedSectionHeaderHeight = 0;
        
        self.refreshFooterView = [MJRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshListTableViewData)];
        self.mj_footer = self.refreshFooterView;
        self.refreshFooterView.backgroundColor = KColor(@"#F6F7F8", 1.0);
        
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}

#pragma -mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataModelArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return KWidthScale(125.f);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DZForumListTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DZForumListTableCell"];
    if (!cell) {
        cell = [[DZForumListTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DZForumListTableCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    [cell updateBookBriefTableViewCell:self.dataModelArray[indexPath.row]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma -mark setter
-(void)setDataModelArray:(NSArray *)dataModelArray{
    _dataModelArray = dataModelArray;
    [self reloadData];
}

-(void)refreshListTableViewData{
    if (self.is_next) {
        if ( [DZMobileCtrl connectedNetwork]) {
            if (self.listDelegate && [self.listDelegate respondsToSelector:@selector(loadVIPCategoryTableViewMoreData:)]) {
                [self.listDelegate loadVIPCategoryTableViewMoreData:self];
            }
        }else{
            [DZMobileCtrl showAlertInfo:KdefaultAlert];
        }
    }else{
        [self.mj_footer endRefreshingWithNoMoreData];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSDictionary *dict = @{@"contentOffsetY":[NSNumber numberWithFloat:scrollView.contentOffset.y]};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshSeprateLineViewNotification" object:nil userInfo:dict];
}

@end
