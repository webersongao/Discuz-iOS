//
//  DZNavigationBar.m
//  PandaReader
//
//  Created by WebersonGao on 2019/4/4.
//  Copyright © 2019 ZHWenXue. All rights reserved.
//

#import "DZNavigationBar.h"
@implementation DZNavigationBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.bottomLine];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    //注意导航栏及状态栏高度适配
    CGFloat systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    for (UIView *view in self.subviews) {
        if([NSStringFromClass([view class]) containsString:@"Background"]) {
            view.frame = self.bounds;
        }else if ([NSStringFromClass([view class]) containsString:@"ContentView"]) {
            CGRect frame = view.frame;
            frame.origin.y = [UIApplication sharedApplication].statusBarFrame.size.height;
            frame.size.height = self.bounds.size.height - frame.origin.y;
            view.frame = frame;
            for (UIView *subView in view.subviews) {
                if ([NSStringFromClass([subView class]) containsString:@"BarStackView"] && systemVersion >= 11.0) {
//                    view.layoutMargins = UIEdgeInsetsMake(view.layoutMargins.top, 8, view.layoutMargins.bottom, 8);
                }
            }
        }
    }
}

-(UIView *)bottomLine{
    if (_bottomLine == nil) {
        _bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.height-0.5, self.width, 0.5)];
        _bottomLine.backgroundColor = KColor(KLine_Color, 1.0);
    }
    return _bottomLine;
}


@end




