//
//  FootForumController.m
//  DiscuzMobile
//
//  Created by HB on 17/5/2.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import "FootForumController.h"
#import "DZForumNodeModel.h"
#import "DZThreadNetTool.h"
#import "DZForumItemCell.h"
#import "DZCollectSectionView.h"

@interface FootForumController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *dataSourceArr;
@property (nonatomic, strong) NSMutableArray<DZForumNodeModel *> *dataSource;

@end

@implementation FootForumController


static NSString *CellID = @"fourmCollection";
static NSString * headerSection = @"CellHeader";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initCollectionView];
    
    [self loadData];
    
    KWEAKSELF;
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
    
    [self.HUD showLoadingMessag:@"正在刷新" toView:self.view];

}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)refresh {
    if ([self.view hu_intersectsWithAnotherView:nil]) {
        // 刷新
        [self.collectionView.mj_header beginRefreshing];
    }
}

- (void)reloadImage {
    [self.collectionView reloadData];
}

- (void)initCollectionView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 4;
    flowLayout.itemSize = CGSizeMake((KScreenWidth - 18 - 18) / 3, KScreenWidth / 3 + 40);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    [self.collectionView registerClass:[DZForumItemCell class] forCellWithReuseIdentifier:CellID];
    [self.collectionView registerClass:[DZCollectSectionView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerSection];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self.view addSubview:self.collectionView];
}

- (void)loadData {
    
    [DZThreadNetTool DZ_DownloadForumCategoryData:0 isCache:YES completion:^(DZDiscoverModel *indexModel) {
        [self.HUD hide];
        if (indexModel) {
            [self.collectionView.mj_header endRefreshing];
            self.dataSourceArr = [NSMutableArray arrayWithArray:indexModel.visitedforums];
            [self emptyShow];
            [self.collectionView reloadData];
        }else{
            [self.collectionView.mj_header endRefreshing];
        }
    }];
    
    [DZApiRequest requestWithConfig:^(JTURLRequest *request) {
        request.isCache = YES;
        request.urlString = DZ_Url_Forumindex;
    } success:^(id responseObject, JTLoadType type) {
        
        
    } failed:^(NSError *error) {
        
    }];
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
    
    CGSize size = CGSizeMake(0, 0);
    
    return size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataSourceArr.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    DZCollectSectionView *cell = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerSection forIndexPath:indexPath];
    return cell;
   
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DZForumItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"fourmCollection" forIndexPath:indexPath];
    
    DZForumNodeModel * node;
    
    node = self.dataSourceArr[indexPath.row];
    
    if (node != nil) {
        [cell updateItemCell:node.infoModel];
    }
    
    return cell;
}

#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    DZForumNodeModel * node = self.dataSourceArr[indexPath.row];
    [self pushThreadList:node];
}

- (void)pushThreadList:(DZForumNodeModel *)node {

    [[DZMobileCtrl sharedCtrl] PushToForumListController:node.infoModel.fid];
}

- (NSMutableArray<DZForumNodeModel *> *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (NSMutableArray *)dataSourceArr {
    if (!_dataSourceArr) {
        _dataSourceArr = [NSMutableArray array];
    }
    return _dataSourceArr;
}

@end
