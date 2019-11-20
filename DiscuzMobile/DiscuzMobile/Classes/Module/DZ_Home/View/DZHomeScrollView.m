//
//  DZHomeScrollView.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/19.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZHomeScrollView.h"
#import "DZThreadContentView.h"

@interface DZHomeScrollView ()<HeaderCollectionDelegate>

@property (nonatomic, strong) DZThreadContentView *contentView;  //!< 属性注释

@end


@implementation DZHomeScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configDZHomeScrollView];
    }
    return self;
}


-(void)configDZHomeScrollView{
    [self addSubview:self.HeaderView];
    [self addSubview:self.contentView];
    self.HeaderView.headerDelegate = self;
}

#pragma mark   /********************* HeaderCollectionDelegate *************************/

- (void)collectionView:(DZHomeCollectionView *)collectionView didSelectItemCell:(DZHomeCollectionCell *)itemCell indexPath:(NSIndexPath *)indexPath{
    
}

- (void)collectionView:(DZHomeCollectionView *)collectionView longPressItemCell:(DZHomeCollectionCell *)itemCell{
    DLog(@"WBS 别按啦，暂时长按没有效果");
}

- (void)collectionView:(DZHomeCollectionView *)collectionView scrollDidScroll:(CGFloat)offsetY{
    
}

- (void)collectionViewWillBeginDragging{
    
}

- (void)collectionViewDidEndRoll{
    
}

-(DZHomeCollectionView *)HeaderView{
    if (_HeaderView == nil) {
        _HeaderView = [[DZHomeCollectionView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, kHomeHeaderHeight) collectionViewLayout:[DZHomeCollectionView gridLayout]];
    }
    return _HeaderView;
}


-(DZThreadContentView *)contentView{
    if (_contentView == nil) {
        _contentView = [[DZThreadContentView alloc] initWithFrame:CGRectMake(0, self.HeaderView.bottom, KScreenWidth, KScreenHeight)];
    }
    return _contentView;
}

@end







