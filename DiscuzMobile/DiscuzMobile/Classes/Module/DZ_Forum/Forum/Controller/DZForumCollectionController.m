//
//  DZForumCollectionController.m
//  DiscuzMobile
//
//  Created by HB on 17/5/2.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import "DZForumCollectionController.h"
#import "DZTreeViewNode.h"
#import "ForumItemCell.h"
#import "ForumReusableView.h"
#import "AsyncAppendency.h"

@interface DZForumCollectionController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSMutableArray<DZTreeViewNode *> *dataSourceArr;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) NSString * urlString;  //!< 属性注释

@end

@implementation DZForumCollectionController

static NSString *CellID = @"fourmCollection";
static NSString * headerSection = @"CellHeader";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initCollectionView];
    [self cacheRequest];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:DZ_TABBARREFRESH_Notify object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadImage) name:DZ_IMAGEORNOT_Notify object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshData) name:DZ_DomainUrlChange_Notify object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)refresh {
    if ([self viewIsShow]) {
        // 刷新
        [self.collectionView.mj_header beginRefreshing];
    }
}

- (void)refreshData {
    // 刷新
    [self loadForumIndexDataWitLoadType:JTRequestTypeRefresh];
}

- (void)reloadImage {
    [self.collectionView reloadData];
}

- (BOOL)viewIsShow {
    //判断window是否在窗口上
    if (self.view.window == nil) {
        return NO;
    }
    //判断当前的view是否与窗口重合
    if (![self.view hu_intersectsWithAnotherView:nil]) {
        return NO;
    }
    
    return YES;
}

- (void)initCollectionView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 4;
    flowLayout.itemSize = CGSizeMake((KScreenWidth - 20 - 20) / 3, KScreenWidth / 3 + 40);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, KNavi_ContainStatusBar_Height, KScreenWidth, KScreenHeight - KNavi_ContainStatusBar_Height) collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    [self.collectionView registerClass:[ForumItemCell class] forCellWithReuseIdentifier:CellID];
    [self.collectionView registerClass:[ForumReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerSection];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.view addSubview:self.collectionView];
    
    KWEAKSELF;
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadForumIndexDataWitLoadType:JTRequestTypeRefresh];
    }];
}

- (void)cacheRequest {
    [self.HUD showLoadingMessag:@"正在刷新" toView:self.view];
    [self loadForumIndexDataWitLoadType:JTRequestTypeCache]; // 读缓存，没有缓存的话自己会请求网络
    if ([JTRequestManager isCache:self.urlString andParameters:nil]) { // 缓存有的话，要刷新一次。缓存没有的话，不请求了，上面那个方法已经请求了
        [self loadForumIndexDataWitLoadType:JTRequestTypeRefresh];
    }
}

- (void)loadForumIndexDataWitLoadType:(JTLoadType)type {
    
    [DZApiRequest requestWithConfig:^(JTURLRequest *request) {
        
        request.urlString = DZ_Url_Forumindex;
        request.isCache = YES;
        request.loadType = type;
        
    } success:^(id responseObject, JTLoadType type) {
        [self.HUD hide];
        [self.collectionView.mj_header endRefreshing];
        
        [self setForumList:responseObject];
        
        [self.collectionView reloadData];
        [self emptyShow];
        
    } failed:^(NSError *error) {
        [self.HUD hide];
        [self showServerError:error];
        [self.collectionView.mj_header endRefreshing];
        [self emptyShow];
    }];
}
// 处理全部版块数据
- (void)setForumList:(id)responseObject {
    self.dataSourceArr = [NSMutableArray arrayWithArray:[DZTreeViewNode setAllforumData:responseObject]];
}

- (void)emptyShow {
    if (self.dataSourceArr.count > 0) {
        self.emptyView.hidden = YES;
    } else {
        self.emptyView.hidden = NO;
        self.emptyView.frame = self.collectionView.frame;
        if (!self.emptyView.isOnView) {
            [self.collectionView addSubview:self.emptyView];
            self.emptyView.isOnView = YES;
        }
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(KScreenWidth, 54);
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    if (!self.dataSourceArr[section].isExpanded)  {
        return UIEdgeInsetsMake(0, 10, 0, 10);
    }
    
    return UIEdgeInsetsMake(10, 10, 10, 10);
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return self.dataSourceArr.count;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (self.dataSourceArr[section].isExpanded) {
        return self.dataSourceArr[section].nodeChildren.count;
    }
    return 0;
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    ForumReusableView *cell = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerSection forIndexPath:indexPath];
    
    cell.tag = indexPath.section;
    UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelectHeaderWithSection:)];
    [cell addGestureRecognizer:tapG];
    cell.node = self.dataSourceArr[indexPath.section];
    
    return cell;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ForumItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"fourmCollection" forIndexPath:indexPath];
    
    DZTreeViewNode * node;
    
    node = self.dataSourceArr[indexPath.section].nodeChildren[indexPath.row];
    
    if (node != nil) {
        [cell setInfo:node.infoModel];
    }
    
    return cell;
}

#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    DZTreeViewNode * node;
    
    node = self.dataSourceArr[indexPath.section].nodeChildren[indexPath.row];
    
    
    [self pushThreadList:node];
}

- (void)pushThreadList:(DZTreeViewNode *)node {
    [[DZMobileCtrl sharedCtrl] PushToForumListController:node.infoModel.fid];
}

- (void)didSelectHeaderWithSection:(UITapGestureRecognizer *)sender {
    
    DZTreeViewNode *node = self.dataSourceArr[sender.view.tag];
    node.isExpanded = !node.isExpanded;
    [self.collectionView reloadData];
    
}

- (NSMutableArray *)dataSourceArr {
    if (!_dataSourceArr) {
        _dataSourceArr = [NSMutableArray array];
    }
    return _dataSourceArr;
}

@end





