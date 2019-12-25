//
//  DZFastPostController.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/25.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZFastPostController.h"
#import "DZForumNodeModel.h"
#import "DZForumLeftCell.h"
#import "FastLevelCell.h"
#import "PostTypeModel.h"
#import "DZPostNetTool.h"
#import "DZThreadNetTool.h"
#import "DZPostNormalController.h"
#import "DZPostVoteController.h"
#import "DZPostTypeSelectView.h"
#import "DZPostDebateController.h"
#import "UIImageView+FindHairline.h"
#import "DZPostActivityController.h"

@interface DZFastPostController ()

@property (nonatomic,assign) BOOL isSelected;
@property (nonatomic, strong) UITableView *leftTable;
@property (nonatomic, strong) NSMutableArray *leftDataArray;
@property (nonatomic, strong) UIButton *closeBtn;
@property (nonatomic, strong) DZPostTypeSelectView *selectView;
@property (nonatomic, copy) NSString *selectFid;
@property (nonatomic, strong) DZBaseAuthModel *authModel;
@property (nonatomic, strong) UIButton *refreshBtn;

@end

@implementation DZFastPostController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 判断左边菜单是否点击选中
    self.isSelected = NO;
    [self configPostSelectController];
    self.dz_NavigationItem.title = @"选择发帖版块";
    
    // 下载数据
    [self cacheAndRequest];
}


-(void)configPostSelectController{
    
    // 左侧菜单
    [self.view addSubview:self.leftTable];
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = K_Color_ForumGray;
    self.tableView.backgroundColor = K_Color_ForumGray;
    [self configNaviBar:@"" type:NaviItemText Direction:NaviDirectionLeft];
    [self.tableView registerClass:[FastLevelCell class] forCellReuseIdentifier:[FastLevelCell getReuseId]];
    
    self.leftTable.frame = CGRectMake(0, KNavi_ContainStatusBar_Height, KScreenWidth *0.22, KView_OutNavi_Bounds.size.height);
    self.tableView.frame = CGRectMake(self.leftTable.right, self.leftTable.top, KScreenWidth *0.78, KView_OutNavi_Bounds.size.height);
    [self.view addSubview:self.closeBtn];
    [self.view addSubview:self.refreshBtn];
    
}

#pragma mark - 请求处理数据
- (void)cacheAndRequest {
    [self.HUD showLoadingMessag:@"正在刷新" toView:self.view];
    [self loadDataWithType:JTRequestTypeCache];
}

// 下载数据
- (void)loadDataWithType:(JTLoadType)loadType {
    
    [DZThreadNetTool DZ_DownloadForumCategoryData:loadType isCache:YES completion:^(DZDiscoverModel *indexModel) {
        [self.HUD hideAnimated:YES];
        if (indexModel) {
            self.refreshBtn.hidden = YES;
            [self.tableView.mj_header endRefreshing];
            [self configForumList:indexModel];
        }else{
            self.refreshBtn.hidden = NO;
        }
    }];
    
}

// 处理全部版块数据
- (void)configForumList:(DZDiscoverModel *)indexModel {
    
    [self.leftDataArray removeAllObjects];
    [self.dataSourceArr removeAllObjects];
    self.leftDataArray = [NSMutableArray arrayWithArray:indexModel.catlist];
    for (DZForumNodeModel *nodeModel in self.leftDataArray) {
        [self.dataSourceArr addObject:nodeModel.childNode];
    }
    [self.tableView reloadData];
    [self.leftTable reloadData];
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
    
    if (tableView == self.leftTable) {
        DZForumNodeModel *node = self.leftDataArray[indexPath.row];
        DZForumLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:[DZForumLeftCell getReuseId] forIndexPath:indexPath];
        [cell updateCellLabel:node.name];
        return cell;
    } else {
        DZForumNodeModel *node = self.dataSourceArr[indexPath.section][indexPath.row];
        FastLevelCell *cell = [tableView dequeueReusableCellWithIdentifier:[FastLevelCell getReuseId] forIndexPath:indexPath];
        [cell updateLevelCell:node];
        [cell.statusBtn addTarget:self action:@selector(clickLevel:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
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
        [self CheckNodeUserPostAuthWithNode:node];
    }
}

-(void)CheckNodeUserPostAuthWithNode:(DZForumNodeModel *)node{
    [self.HUD showLoadingMessag:@"验证发帖权限" toView:self.view];
    [[DZPostNetTool sharedTool] DZ_CheckUserPostAuth:node.infoModel.fid success:^(DZBaseAuthModel *authModel) {
        [self.HUD hide];
        if (authModel) {
            self.authModel = authModel;
            if (authModel.group) { // 能发的帖子类型处理
                NSString *allowspecialonly = authModel.forum.allowspecialonly;
                [self.selectView setPostType:checkInteger(authModel.group.allowpostpoll)
                                    activity:checkInteger(authModel.group.allowpostactivity)
                                      debate:checkInteger(authModel.group.allowpostdebate)
                            allowspecialonly:allowspecialonly
                                   allowpost:authModel.allowperm.allowpost];
            } else {
                [MBProgressHUD showInfo:@"暂无发帖权限"];
            }
        }else{
            [MBProgressHUD showInfo:@"暂无发帖权限"];
        }
    }];
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


#pragma mark   /********************* 交互事件 *************************/

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
    [[DZMobileCtrl sharedCtrl] PushToThreadPostController:self.selectFid thread:self.authModel type:type];
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

#pragma mark   /********************* 初始化 *************************/

- (UITableView *)leftTable {
    if (_leftTable == nil) {
        _leftTable = [[DZBaseTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width * 0.22, self.view.frame.size.height) style:UITableViewStylePlain];
        _leftTable.backgroundColor = K_Color_ForumGray;
        _leftTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _leftTable.delegate = self;
        _leftTable.dataSource = self;
        [_leftTable registerClass:[DZForumLeftCell class] forCellReuseIdentifier:[DZForumLeftCell getReuseId]];
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
        [_closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _closeBtn.frame = CGRectMake((KScreenWidth - kToolBarHeight)/2.f, KScreenHeight - KTabbar_Height + 5, kToolBarHeight, kToolBarHeight);
    }
    return _closeBtn;
}

- (UIButton *)refreshBtn {
    if (!_refreshBtn) {
        _refreshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _refreshBtn.layer.borderColor = K_Color_Message.CGColor;
        _refreshBtn.layer.borderWidth = 1;
        _refreshBtn.layer.cornerRadius = 5;
        _refreshBtn.hidden = YES;
        _refreshBtn.frame = CGRectMake(0, 0, 100, 50);
        _refreshBtn.center = CGPointMake(self.view.width/2.f, self.view.height/2.f);
        [_refreshBtn setTitleColor:K_Color_Message forState:UIControlStateNormal];
        [_refreshBtn setTitle:@"刷新" forState:UIControlStateNormal];
        [_refreshBtn addTarget:self action:@selector(errorRefresh) forControlEvents:UIControlEventTouchUpInside];
    }
    return _refreshBtn;
}

-(DZPostTypeSelectView *)selectView{
    if (!_selectView) {
        _selectView = [[DZPostTypeSelectView alloc] init];
        KWEAKSELF;
        _selectView.typeBlock = ^(PostType type) {
            [weakSelf.selectView close];
            [weakSelf switchTypeTopost:type];
        };
    }
    return _selectView;
}



@end
