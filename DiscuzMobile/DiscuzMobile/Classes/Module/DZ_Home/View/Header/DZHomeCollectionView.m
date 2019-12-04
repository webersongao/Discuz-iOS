//
//  DZHomeCollectionView.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/19.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZHomeCollectionView.h"

static NSString * const cellIdentifier = @"DZThreadCell";

@interface DZHomeCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UIPageControl *PageControl;  //!< 属性注释

@end

@implementation DZHomeCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        [self configHomeCollectionView];
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.backgroundColor = [UIColor whiteColor];
        [self registerClass:[DZHomeCollectionCell class] forCellWithReuseIdentifier:cellIdentifier];
    }
    return self;
}


-(void)configHomeCollectionView{
    [self addSubview:self.PageControl];
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(lonePressRecognizerAction:)];
    [self addGestureRecognizer:longPress];
}

// 重置 列表数组数据 的唯一方法
-(void)reloadDataSource:(NSArray <DZForumModel *>*)array{
    if (array && [array isKindOfClass:[NSArray class]]) {
        _dataArray = array;
    }
    self.hidden = self.dataArray.count ? NO : YES;
    self.PageControl.numberOfPages = ceil(array.count/(kRowNumber * 1.0));
    [self reloadHomeListThreadData];
}


// 列表刷新
-(void)reloadHomeListThreadData{
    [self reloadSections:[NSIndexSet indexSetWithIndex:0]];
}


/// 长按手势
-(void)lonePressRecognizerAction:(UILongPressGestureRecognizer *)longPressGes{
    if (longPressGes.state == UIGestureRecognizerStateBegan) {
        NSIndexPath *indexPath = [self indexPathForItemAtPoint:[longPressGes locationInView:self]];
        DZHomeCollectionCell *cell = (DZHomeCollectionCell *)[self cellForItemAtIndexPath:indexPath];
        if (cell && self.headerDelegate && [self.headerDelegate respondsToSelector:@selector(collectionView:longPressItemCell:)]) {
            [self.headerDelegate collectionView:self longPressItemCell:cell];
        }
    }
}
#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DZHomeCollectionCell *homeCell = (DZHomeCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    [homeCell updateForumCellWithModel:self.dataArray[indexPath.row]];

    return homeCell;
}

#pragma mark <UICollectionViewDelegate>
/// 点击某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DZHomeCollectionCell *itemCell = (DZHomeCollectionCell *)[self cellForItemAtIndexPath:indexPath];
    
    if (self.headerDelegate && [self.headerDelegate respondsToSelector:@selector(collectionView:didSelectItemCell: indexPath:)]) {
        [self.headerDelegate collectionView:self didSelectItemCell:itemCell indexPath:indexPath];
    }
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (self.headerDelegate && [self.headerDelegate respondsToSelector:@selector(collectionView:scrollDidScroll:)]) {
        [self.headerDelegate collectionView:self scrollDidScroll:offsetY];
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (self.headerDelegate && [self.headerDelegate respondsToSelector:@selector(collectionViewWillBeginDragging)]) {
        [self.headerDelegate collectionViewWillBeginDragging];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.headerDelegate && [self.headerDelegate respondsToSelector:@selector(collectionViewDidEndScroll)]) {
        [self.headerDelegate collectionViewDidEndScroll];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        if (self.headerDelegate && [self.headerDelegate respondsToSelector:@selector(collectionViewDidEndScroll)]) {
            [self.headerDelegate collectionViewDidEndScroll];
        }
    }
}

// 列表 九宫格模式 布局
+(UICollectionViewFlowLayout *)gridLayout{
    UICollectionViewFlowLayout * gridLayout = [[UICollectionViewFlowLayout alloc] init];
    gridLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    gridLayout.itemSize = CGSizeMake(kCellWidth, kCellHeight);
    gridLayout.minimumLineSpacing = kItemSpacing;
    gridLayout.minimumInteritemSpacing = kLineSpacing;
    gridLayout.sectionInset = UIEdgeInsetsMake(0,kCellMargins, 0, kCellMargins);
    return gridLayout;
}

-(UIPageControl *)PageControl{
    if (_PageControl == nil) {
        _PageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.height - kMargin15, KScreenWidth, kMargin10)];
        _PageControl.currentPage = 0;
        _PageControl.userInteractionEnabled = NO;
        _PageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        _PageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    }
    return _PageControl;
}

@end
