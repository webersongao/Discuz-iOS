//
//  DZBaseCollectionView.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/22.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DZRefreshState) {
    DZRefreshStateNone = 1,
    DZRefreshStateSuccess, //刷新成功了并且有数据
    DZRefreshStateDataFinish, //刷新成功了但是没数据
    MJRefreshStateError //刷新失败
};

@interface DZBaseCollectionView : UICollectionView

@property(nonatomic,strong,readonly) NSArray *dataArray;
@property (nonatomic, strong) UICollectionViewFlowLayout *gridLayout;
@property (nonatomic, strong) UICollectionViewFlowLayout *listLayout;

@property(nonatomic,copy) backNoneBlock refreshAction;
@property(nonatomic,copy) backNoneBlock loadMoreAction;

- (instancetype)initWithListFrame:(CGRect)frame;

-(void)dataSource:(NSArray *)array;

/// 刷新列表数据 弃用 reloadData
-(void)reloadCollectionListData;

/// 列表下拉刷新
-(void)headerViewPullDownAction;

-(void)lonePressRecognizerAction:(UILongPressGestureRecognizer *)longPressGes;

//下拉刷新结束
- (void)refreshBookEnd:(DZRefreshState)state;

//上拉加载更多结束
- (void)loadMoreBookEnd:(DZRefreshState)state;

@end

