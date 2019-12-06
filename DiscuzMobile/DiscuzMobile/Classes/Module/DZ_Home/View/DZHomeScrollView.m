//
//  DZHomeScrollView.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/19.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZHomeScrollView.h"
#import "DZHomeThreadContentView.h"

@interface DZHomeScrollView ()<HeaderCollectionDelegate,UIScrollViewDelegate,ThreadContentViewDelegate>

@property (nonatomic, strong) DZHomeThreadContentView *contentView;  //!< 属性注释

@end


@implementation DZHomeScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.bounces = NO;
        self.delegate = self;
        [self configDZHomeScrollView];
    }
    return self;
}


-(void)configDZHomeScrollView{
    [self addSubview:self.HeaderView];
    [self addSubview:self.contentView];
    self.HeaderView.headerDelegate = self;
    self.contentView.listDelgate = self;
    self.contentView.ListScrollEnabled = NO;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

#pragma mark   /********************* HeaderCollectionDelegate *************************/

- (void)collectionView:(DZHomeCollectionView *)collectionView didSelectItemCell:(DZHomeCollectionCell *)itemCell indexPath:(NSIndexPath *)indexPath{
    DLog(@"WBS 点击了 板块：%@",itemCell.cellModel.name);
}

- (void)collectionView:(DZHomeCollectionView *)collectionView longPressItemCell:(DZHomeCollectionCell *)itemCell{
    DLog(@"WBS 别按啦，暂时长按没有效果");
}

- (void)collectionView:(DZHomeCollectionView *)collectionView scrollDidScroll:(CGFloat)offsetY{
    
}

- (void)collectionViewWillBeginDragging{
    
}

- (void)collectionViewDidEndScroll{
    
}

#pragma mark   /********************* UIScrollViewDelegate *************************/
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    DLog(@"上面 偏移量%.2f",scrollView.contentOffset.y);
    [self homeViewScrollViewYScroll:scrollView];
}

#pragma mark   /********************* ThreadContentViewDelegate *************************/

- (void)threadListContentView:(UIScrollView *)scrollView scrollDidScroll:(CGFloat)offsetY{
    DLog(@"下面 偏移量%.2f",offsetY);
    [self homeViewScrollViewYScroll:scrollView];
}

-(void)homeViewScrollViewYScroll:(UIScrollView *)scrollView{
    if ([scrollView isEqual:self]) {
        
    }else if ([scrollView isKindOfClass:[UITableView class]]){
        
    }
}

-(DZHomeCollectionView *)HeaderView{
    if (_HeaderView == nil) {
        _HeaderView = [[DZHomeCollectionView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, kHomeHeaderHeight) collectionViewLayout:[DZHomeCollectionView gridLayout]];
    }
    return _HeaderView;
}


-(DZHomeThreadContentView *)contentView{
    if (_contentView == nil) {
        _contentView = [[DZHomeThreadContentView alloc] initWithFrame:CGRectMake(0, self.HeaderView.bottom, KScreenWidth, KScreenHeight)];
    }
    return _contentView;
}

@end







