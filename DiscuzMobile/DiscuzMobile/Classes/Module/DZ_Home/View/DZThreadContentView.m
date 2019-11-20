//
//  DZThreadContentView.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/20.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZThreadContentView.h"
#import "DZThreadContentController.h"

@interface DZThreadContentView ()
@property (nonatomic, strong) DZThreadContentController *contentVC;  //!< 属性注释
@end

@implementation DZThreadContentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self layoutThreadContentView];
        self.backgroundColor = [UIColor yellowColor];
    }
    return self;
}


-(void)layoutThreadContentView{
    [self addSubview:self.contentVC.view];
}


-(DZThreadContentController *)contentVC{
    if (_contentVC == nil) {
        _contentVC = [[DZThreadContentController alloc] init];
    }
    return _contentVC;
}







@end


