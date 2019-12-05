//
//  FastPostController.m
//  DiscuzMobile
//
//  Created by ZhangJitao on 2018/7/17.
//  Copyright © 2018年 comsenz-service.com.  All rights reserved.
//

#import "FastPostController.h"
#import "DZForumNodeModel.h"
#import "DZForumLeftCell.h"
#import "FastLevelCell.h"
#import "PostTypeModel.h"
#import "DZThreadNetTool.h"
#import "DZPostNormalViewController.h"
#import "DZPostVoteViewController.h"
#import "DZPostTypeSelectView.h"
#import "DZPostDebateController.h"
#import "UIImageView+FindHairline.h"
#import "DZPostActivityViewController.h"

@interface FastPostController ()

@property (nonatomic,assign) BOOL isSelected;
@property (nonatomic, strong) NSMutableArray *leftDataArray;
@property (nonatomic, strong) UIButton *closeBtn;
@property (nonatomic, strong) DZPostTypeSelectView *selectView;
@property (nonatomic, copy) NSString *selectFid;
@property (nonatomic, strong) NSMutableDictionary *Variables;

@property (nonatomic, strong) UIImageView *navBarHairlineImageView;
@property (nonatomic, strong) UIButton *refreshBtn;

@end

@implementation FastPostController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _navBarHairlineImageView.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    _navBarHairlineImageView.hidden = NO;
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dz_NavigationItem.title = @"选择发帖版块";
    _navBarHairlineImageView = [UIImageView findHairlineImageViewUnder:self.navigationController.navigationBar];
    [self configNaviBar:@"" type:NaviItemText Direction:NaviDirectionLeft];
    
    // 判断左边菜单是否点击选中
    self.isSelected = NO;
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = K_Color_ForumGray;
    // 做菜单
    [self.view addSubview:self.leftTable];
    [self.leftTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.height.equalTo(self.view).offset(-self.tabbarHeight);
        make.top.equalTo(@0);
        make.width.equalTo(self.view).multipliedBy(0.22);
    }];
    
    // 右内容
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftTable.mas_right);
        make.top.equalTo(self.leftTable);
        make.right.equalTo(self.view);
        make.height.equalTo(self.view).offset(-self.tabbarHeight);
    }];
    self.tableView.backgroundColor = K_Color_ForumGray;
    [self.leftTable registerClass:[DZForumLeftCell class] forCellReuseIdentifier:[DZForumLeftCell getReuseId]];
    [self.tableView registerClass:[FastLevelCell class] forCellReuseIdentifier:[FastLevelCell getReuseId]];
    
    [self.view addSubview:self.closeBtn];
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tableView.mas_bottom).offset(2);
        make.centerX.equalTo(self.view);
        make.width.height.equalTo(@44);
    }];
    [self.closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.selectView = [[DZPostTypeSelectView alloc] init];
    KWEAKSELF;
    self.selectView.typeBlock = ^(PostType type) {
        [weakSelf.selectView close];
        [weakSelf switchTypeTopost:type];
    };
    
    [self.view addSubview:self.refreshBtn];
    [self.refreshBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.equalTo(@100);
        make.height.equalTo(@50);
    }];
    [self.view layoutIfNeeded];
    self.refreshBtn.layer.cornerRadius = 5;
    self.refreshBtn.hidden = YES;
    
    // 下载数据
    [self cacheAndRequest];
}

#pragma mark - 请求处理数据
- (void)cacheAndRequest {
    [self.HUD showLoadingMessag:@"正在刷新" toView:self.view];
    [self loadDataWithType:JTRequestTypeCache];
    if ([DZApiRequest isCache:DZ_Url_Forumindex andParameters:nil]) {
        [self loadDataWithType:JTRequestTypeRefresh];
    }
}

// 下载数据
- (void)loadDataWithType:(JTLoadType)loadType {
    
    [DZThreadNetTool DZ_DownloadForumCategoryData:loadType isCache:YES completion:^(DZDiscoverModel *indexModel) {
        
        if (indexModel) {
            self.refreshBtn.hidden = YES;
            [self.HUD hideAnimated:YES];
            [self.tableView.mj_header endRefreshing];
            if ([DataCheck isValidArray:self.leftDataArray]) {
                [self.leftDataArray removeAllObjects];
            }
            [self configForumList:indexModel];
            [self.tableView reloadData];
            [self.leftTable reloadData];
        }else{
            self.refreshBtn.hidden = NO;
            [self.HUD hideAnimated:YES];
        }
    }];
    
}

// 处理全部版块数据
- (void)configForumList:(DZDiscoverModel *)indexModel {
    
    [self.dataSourceArr removeAllObjects];
    self.leftDataArray = [NSMutableArray arrayWithArray:indexModel.catlist];
    for (DZForumNodeModel *nodeModel in self.leftDataArray) {
        [self.dataSourceArr addObjectsFromArray:nodeModel.childNode];
    }
}

- (void)errorRefresh {
    [self loadDataWithType:JTRequestTypeRefresh];
}

#pragma mark - 发帖类型框Action
- (void)showTypeView {
    
    if (![self isLogin]) {
        return;
    }
    if (self.selectView.typeArray.count == 0) {
        [MBProgressHUD showInfo:@"您当前无权限发帖"];
        return;
    } else if (self.selectView.typeArray.count == 1) {
        PostTypeModel *model = self.selectView.typeArray[0];
        [self switchTypeTopost:model.type];
    } else {
        [self.selectView show];
    }
}

#pragma mark - 点击去往发帖页
- (void)switchTypeTopost:(PostType)type {
    switch (type) {
        case post_normal:
            [self postNormal];
            break;
        case post_vote:
            [self postVote];
            break;
        case post_activity:
            [self postActivity];
            break;
        case post_debate:
            [self postDebate];
            break;
        default:
            break;
    }
}

- (void)publicPostControllerSet:(DZPostBaseController *)controller {
    KWEAKSELF;
#warning 该位置需要完全转换成Model赋值，此写法只是为了不报错 临时注释
    //    controller.dataForumTherad = self.Variables;
    controller.fid = self.selectFid;
    controller.pushDetailBlock = ^(NSString *tid) {
        [weakSelf postSucceedToDetail:tid];
    };
    [[DZMobileCtrl sharedCtrl] PushToController:controller];
}

- (void)postNormal {
    DZPostNormalViewController * tvc = [[DZPostNormalViewController alloc] init];
    [self publicPostControllerSet:tvc];
}

- (void)postVote {
    DZPostVoteViewController * vcv = [[DZPostVoteViewController alloc] init];
    [self publicPostControllerSet:vcv];
}

- (void)postActivity {
    DZPostActivityViewController * ivc = [[DZPostActivityViewController alloc] init];
    [self publicPostControllerSet:ivc];
}

- (void)postDebate {
    DZPostDebateController *debateVC = [[DZPostDebateController alloc] init];
    [self publicPostControllerSet:debateVC];
}

- (void)postSucceedToDetail:(NSString *)tid {
    [[DZMobileCtrl sharedCtrl] PushToThreadDetailController:tid];
}

- (void)closeBtnClick {
    [[NSNotificationCenter defaultCenter] postNotificationName:DZ_configSelectedIndex_Notify object:nil];
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)reloadSection:(NSInteger)section withNodeModel:(DZForumNodeModel *)model withExpand:(BOOL)isExpand {
    
    NSMutableArray *sectionDataArry = [self.dataSourceArr objectAtIndex:section];
    
    // 点击的行
    NSInteger currentRow = [sectionDataArry indexOfObject:model];
    NSIndexPath *currentIndexPath = [NSIndexPath indexPathForRow:currentRow inSection:section];
    
    
    // 点击末行的时候需要滚动
    NSIndexPath *scrollIndexPath;
    
    if (isExpand){
        
        [self expandInsertRow:currentIndexPath nodeModel:model];
        
        // 需要滚动的下标
        NSInteger mustvisableRow = currentRow + 1;
        if (model.childNode.count >= 2) {
            mustvisableRow = currentRow + 2;
        }
        scrollIndexPath = [NSIndexPath indexPathForRow:mustvisableRow inSection:section];
        
    } else {
        
        [self expandDeleteRow:currentIndexPath nodeModel:model];
        
        scrollIndexPath = [NSIndexPath indexPathForRow:currentRow inSection:section];
    }
    
    // 更新当前行的箭头
    [self.tableView reloadRowsAtIndexPaths:@[currentIndexPath] withRowAnimation:UITableViewRowAnimationNone];
    
    // 滚动
    UITableViewCell *scrollCell = [self.tableView cellForRowAtIndexPath:scrollIndexPath];
    if(![[self.tableView visibleCells] containsObject:scrollCell]) {
        [self.tableView scrollToRowAtIndexPath:currentIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
}

// 插入行
- (void)expandInsertRow:(NSIndexPath *)indexPath nodeModel:(DZForumNodeModel *)model {
    NSMutableArray *sectionDataArry = [self.dataSourceArr objectAtIndex:indexPath.section];
    // 这一步是防止在二级展开的情况下,关闭一级展开, 则二级展开的状态还是展开,需要手动置回 NO
    for (int i =0; i<model.childNode.count; i++) {
        DZForumNodeModel *mod = [model.childNode objectAtIndex:i];
        mod.isExpanded = NO;
    }
    // 插入数据源
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(indexPath.row+1, model.childNode.count)];
    [sectionDataArry insertObjects:model.childNode atIndexes:indexSet];
    
    // 插入行下标数组
    NSMutableArray *reloadIndexPaths = [NSMutableArray array];
    for (int i = 0; i < model.childNode.count; i ++) {
        NSIndexPath *idxPath = [NSIndexPath indexPathForRow:i + indexPath.row + 1 inSection:indexPath.section];
        [reloadIndexPaths addObject:idxPath];
    }
    
    // 插入行
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:reloadIndexPaths withRowAnimation:UITableViewRowAnimationBottom];
    [self.tableView endUpdates];
}

// 删除行
- (void)expandDeleteRow:(NSIndexPath *)indexPath nodeModel:(DZForumNodeModel *)model {
    NSMutableArray *sectionDataArry = [self.dataSourceArr objectAtIndex:indexPath.section];
    // 获取当前行下的所有子节点的数目
    int count = 0;
    for (int i = indexPath.row; i < sectionDataArry.count; i ++) {
        DZForumNodeModel *mod = [sectionDataArry objectAtIndex:i];
        if (mod.nodeLevel > model.nodeLevel) {
            count ++;
        }
    }
    // 移除数据源
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(indexPath.row+1, count)];
    [sectionDataArry removeObjectsAtIndexes:indexSet];
    
    // 需要删除的行下标数组
    NSMutableArray *reloadIndexPaths = [NSMutableArray array];
    for (int i = 0; i < count; i ++) {
        NSIndexPath *idxPath = [NSIndexPath indexPathForRow:i + indexPath.row + 1 inSection:indexPath.section];
        [reloadIndexPaths addObject:idxPath];
    }
    
    // 删除行
    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths:reloadIndexPaths withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView endUpdates];
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.leftTable) {
        return 1;
    }
    return self.dataSourceArr.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.leftTable) {
        return self.leftDataArray.count;
    }
    NSArray *array = self.dataSourceArr[section];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *textStr = @"";
    
    if (tableView == self.leftTable) {
        DZForumNodeModel *node = self.leftDataArray[indexPath.row];
        textStr = node.name;
        DZForumLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:[DZForumLeftCell getReuseId]];
        [cell updateCellLabel:textStr];
        return cell;
    } else {
        NSArray *nodeArr = self.dataSourceArr[indexPath.section];
        DZForumNodeModel *node = nodeArr[indexPath.row];
        FastLevelCell *cell = [tableView dequeueReusableCellWithIdentifier:[FastLevelCell getReuseId]];
        [cell updateLevelCell:node];
        [cell.statusBtn addTarget:self action:@selector(clickLevel:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
}

- (void)clickLevel:(UIButton *)sender {
    FastLevelCell *cell = (FastLevelCell *)sender.superview;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NSArray *nodeArray = self.dataSourceArr[indexPath.section];
    DZForumNodeModel *node = nodeArray[indexPath.row];
    if ([DataCheck isValidArray:node.childNode]) {
        node.isExpanded = !node.isExpanded;
        [self reloadSection:indexPath.section withNodeModel:node withExpand:node.isExpanded];
    }
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.leftTable) {
        return 44;
    }
    return 60;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (tableView == self.tableView) {
        DZForumNodeModel *node = self.leftDataArray[section];
        return node.name;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.leftTable) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.row] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        self.isSelected = YES;
    } else {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        NSArray *nodeArr = self.dataSourceArr[indexPath.section];
        DZForumNodeModel *node = nodeArr[indexPath.row];
        self.selectFid = node.infoModel.fid;
        
        NSDictionary * dic =@{@"fid":node.infoModel.fid};
        [DZApiRequest requestWithConfig:^(JTURLRequest *request) {
            [self.HUD showLoadingMessag:@"验证发帖权限" toView:self.view];
            request.urlString = DZ_Url_CheckPostAuth;
            request.parameters = dic;
            
            // ------------------ 这个地方，请求加个缓存 ------------
            request.loadType = JTRequestTypeCache;
            request.isCache = YES;
            // ------------------ 这个地方，请求加个缓存 ------------
            
        } success:^(id responseObject, JTLoadType type) {
            DLog(@"%@",responseObject);
            [self.HUD hideAnimated:YES];
            self.Variables = [responseObject objectForKey:@"Variables"];
            NSDictionary *group = [self.Variables objectForKey:@"group"];
            if ([DataCheck isValidDictionary:group]) { // 能发的帖子类型处理
                NSString *allowpost = [[self.Variables objectForKey:@"allowperm"] objectForKey:@"allowpost"];
                
                NSString *allowpostpoll = @"0";
                NSString *allowpostactivity = @"0";
                NSString *allowpostdebate = @"0";
                if ([DataCheck isValidString:[group objectForKey:@"allowpostpoll"]]) {
                    allowpostpoll = [group objectForKey:@"allowpostpoll"];
                }
                if ([DataCheck isValidString:[group objectForKey:@"allowpostactivity"]]) {
                    allowpostactivity = [group objectForKey:@"allowpostactivity"];
                }
                if ([DataCheck isValidString:[group objectForKey:@"allowpostdebate"]]) {
                    allowpostdebate = [group objectForKey:@"allowpostdebate"];
                }
                NSString *allowspecialonly = [[self.Variables objectForKey:@"forum"] objectForKey:@"allowspecialonly"];
                [self.selectView setPostType:allowpostpoll
                                    activity:allowpostactivity
                                      debate:allowpostdebate
                            allowspecialonly:allowspecialonly
                                   allowpost:allowpost];
                
            } else {
                [MBProgressHUD showInfo:@"暂无发帖权限"];
            }
            
        } failed:^(NSError *error) {
            [self.HUD hideAnimated:YES];
            [self showServerError:error];
        }];
        
    }
}

// 向下滑（将出现的要重新计算一下）
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    if (tableView == self.tableView) {
        UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
        header.textLabel.font = [DZFontSize HomecellTimeFontSize14];
        header.contentView.backgroundColor = [UIColor whiteColor];
        [self leftTableSet];
    }
}
// 向上滑（滑动到上面的时候要算一下）包括刚出现
- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section {
    if (tableView == self.tableView) {
        [self leftTableSet];
    }
}

// 右边滑动的时候，左边设置下点击状态
- (void)leftTableSet {
    // 判断，如果是左边点击触发的滚动，这不执行下面代码
    if (self.isSelected) {
        return;
    }
    // 获取可见视图的第一个row
    NSInteger currentSection = [[[self.tableView indexPathsForVisibleRows] firstObject] section];
    NSIndexPath *index = [NSIndexPath indexPathForRow:currentSection inSection:0];
    // 点击左边对应区块
    [self.leftTable selectRowAtIndexPath:index animated:YES scrollPosition:UITableViewScrollPositionTop];
}

// 开始拖动赋值没有点击
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    // 当右边视图将要开始拖动时，则认为没有被点击了。
    self.isSelected = NO;
}

#pragma mark - setter getter
- (UITableView *)leftTable {
    if (_leftTable == nil) {
        _leftTable = [[DZBaseTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width * 0.22, self.view.frame.size.height) style:UITableViewStylePlain];
        _leftTable.backgroundColor = K_Color_ForumGray;
        _leftTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _leftTable.delegate = self;
        _leftTable.dataSource = self;
        _leftTable.tableFooterView = [[UIView alloc] init];
    }
    return _leftTable;
}

- (NSMutableArray *)leftDataArray {
    if (!_leftDataArray) {
        _leftDataArray = [NSMutableArray array];
    }
    return _leftDataArray;
}

- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setImage:[UIImage imageNamed:@"closeTz"] forState:UIControlStateNormal];
    }
    return _closeBtn;
}

- (UIButton *)refreshBtn {
    if (!_refreshBtn) {
        _refreshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _refreshBtn.layer.borderColor = K_Color_Message.CGColor;
        _refreshBtn.layer.borderWidth = 1;
        [_refreshBtn setTitleColor:K_Color_Message forState:UIControlStateNormal];
        [_refreshBtn setTitle:@"刷新" forState:UIControlStateNormal];
        [_refreshBtn addTarget:self action:@selector(errorRefresh) forControlEvents:UIControlEventTouchUpInside];
    }
    return _refreshBtn;
}

- (NSMutableDictionary *)Variables {
    if (!_Variables) {
        _Variables = [NSMutableDictionary dictionary];
    }
    return _Variables;
}


@end
