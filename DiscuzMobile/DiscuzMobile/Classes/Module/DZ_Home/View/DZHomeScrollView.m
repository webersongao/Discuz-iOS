//
//  DZHomeScrollView.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/19.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZHomeScrollView.h"
#import "DZHomeCollectionView.h"
#import "DZThreadContentController.h"

@interface DZHomeScrollView ()

@property (nonatomic, strong) DZHomeCollectionView *HeaderView;  //!< 属性注释
@property (nonatomic, strong) DZThreadContentController *contentVC;  //!< 属性注释

@end


@implementation DZHomeScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

@end
