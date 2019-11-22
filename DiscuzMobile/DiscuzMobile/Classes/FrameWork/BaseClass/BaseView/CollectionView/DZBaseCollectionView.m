//
//  DZBaseCollectionView.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/22.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZBaseCollectionView.h"
#import "DZRefreshHeader.h"
#import "DZRefreshFooter.h"

#define  kLineSpacing       KWidthScale(20.f)   //    行间距 |
#define  kItemSpacing       KWidthScale(10.f)  //    item之间的最小列间距  实际上是自动计算
#define  kCellMargins       KWidthScale(15.f)  //    左右缩进
#define  kRowNumber         3    //列数
#define  kCellWidth         KWidthScale(105.f)  //    Cell宽度
#define  kCellHeight        KWidthScale(150.f)  //    Cell高度 // kCellWidth + kCellTextSpace + kCellTextHeight


@interface DZBaseCollectionView ()

@end

@implementation DZBaseCollectionView

- (instancetype)initWithListFrame:(CGRect)frame
{
    self = [super initWithFrame:frame collectionViewLayout:self.listLayout];
    if (self) {
        [self layoutSubviewConfig];
        self.backgroundColor =[UIColor clearColor];
        if (@available(iOS 11.0, *)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
    }
    return self;
}

-(void)layoutSubviewConfig{

    [self addRefreshHeaderView];
//    [self addRefreshFooterView];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(lonePressRecognizerAction:)];
    [self addGestureRecognizer:longPress];
}

- (void)addRefreshHeaderView
{
    if (!self.mj_header) {
        KWEAKSELF
        self.mj_header = [DZRefreshHeader headerWithRefreshingBlock:^{
            [weakSelf headerViewPullDownAction];
        }];
    }
}

- (void)addRefreshFooterView
{
    if (!self.mj_footer) {
        KWEAKSELF
        DZRefreshFooter *footer = [DZRefreshFooter footerWithRefreshingBlock:^{
            [weakSelf footerViewPullUpAction];
        }];
        footer.onlyRefreshPerDrag = YES;
        self.mj_footer = footer;
    }
}

// 重置 列表数组数据 的唯一方法
-(void)dataSource:(NSArray *)array{
    if (array && [array isKindOfClass:[NSArray class]]) {
        _dataArray = array;
    }
    self.hidden = self.dataArray.count ? NO : YES;
    [self reloadCollectionListData];
}


// 列表刷新
-(void)reloadCollectionListData{
    [self reloadSections:[NSIndexSet indexSetWithIndex:0]];
}

-(void)lonePressRecognizerAction:(UILongPressGestureRecognizer *)longPressGes{
    
}

#pragma mark -- data refresh and more
/// 列表下拉刷新
-(void)headerViewPullDownAction{
    
    if (self.refreshAction) {
        self.refreshAction();
    }
}

/// 列表上拉加载更多
-(void)footerViewPullUpAction{

    if (self.loadMoreAction) {
        self.loadMoreAction();
    }
}

- (void)refreshBookEnd:(DZRefreshState)state
{
    KWEAKSELF
    [self.mj_header endRefreshingWithCompletionBlock:^{
        if (state == DZRefreshStateSuccess) {
            [weakSelf addRefreshFooterView];
            weakSelf.mj_footer.hidden = NO;
        }
    }];
}

- (void)loadMoreBookEnd:(DZRefreshState)state
{
    KWEAKSELF
    [self.mj_footer endRefreshingWithCompletionBlock:^{
        if (state == DZRefreshStateDataFinish) {
            weakSelf.mj_footer.hidden = YES;
        }
    }];
}

#pragma mark   /********************* 初始化控件 *************************/

// 列表 九宫格模式 布局
-(UICollectionViewFlowLayout *)gridLayout{
    if (_gridLayout == nil) {
        _gridLayout = [[UICollectionViewFlowLayout alloc] init];
        _gridLayout.minimumLineSpacing = 10.f;
        _gridLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _gridLayout.itemSize = CGSizeMake(kCellWidth, kCellHeight);
        _gridLayout.minimumLineSpacing = kLineSpacing;
        _gridLayout.minimumInteritemSpacing = kItemSpacing;
        _gridLayout.sectionInset = UIEdgeInsetsMake(0,kCellMargins, kCellMargins, kCellMargins);
    }
    return _gridLayout;
}

// 列表 列表模式 布局
-(UICollectionViewFlowLayout *)listLayout{
    if (_listLayout == nil) {
        _listLayout = [[UICollectionViewFlowLayout alloc] init];
        _listLayout.minimumLineSpacing = 10.f;
        _listLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _listLayout.itemSize = CGSizeMake(KScreenWidth, kCellWidth);
        _listLayout.minimumLineSpacing = 0;  // 行间距 (上下间隔)
        _listLayout.minimumInteritemSpacing = 0;  // 列间距 (左右间隔)
        _listLayout.sectionInset = UIEdgeInsetsMake(0,kCellMargins, kCellMargins, kCellMargins);
    }
    return _listLayout;
}



@end
