//
//  ThreadDetailView.m
//  DiscuzMobile
//
//  Created by HB on 16/11/25.
//  Copyright © 2016年 comsenz-service.com.  All rights reserved.
//

#import "ThreadDetailView.h"

@interface ThreadDetailView ()

@end

@implementation ThreadDetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self p_setupViews];
    }
    return self;
}

- (void)p_setupViews {
    
    [self addSubview:self.webView];
    [self addSubview:self.emoKeyboard];
    // 创建键盘
    [self createHPGrowingTextView];
    self.backgroundColor = [UIColor whiteColor];
}



#pragma mark -  创建表情键盘
- (void)createHPGrowingTextView {
    KWEAKSELF;
    __block CGFloat height = 0;
    self.emoKeyboard.changeBlock = ^(CGFloat everyHeight, CGFloat changeHeight) {
        height = changeHeight;
    };
    
    self.emoKeyboard.keyboardShowBlock = ^ {
        [weakSelf.emoKeyboard.textBarView resetViewWithStatus:bar_rise andTextHeight:35 + height];
    };
    self.emoKeyboard.keyboardHideBlock = ^ {
        [weakSelf.emoKeyboard.textBarView resetViewWithStatus:bar_drop andTextHeight:35 + height];
    };
}

- (DZEmoticonKeyboard *)emoKeyboard {
    if (_emoKeyboard == nil) {
        _emoKeyboard = [[DZEmoticonKeyboard alloc] initWithFrame:CGRectMake(0, self.height - KTabbar_Height, self.width, KTabbar_Height)];
        _emoKeyboard.backgroundColor = K_Color_MainGray;
        _emoKeyboard.textBarView.style = detail_textBar;
    }
    return _emoKeyboard;
}

-(DZWebView *)webView{
    if (!_webView) {
        _webView = [[DZWebView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height-KTabbar_Height)];
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.scrollView.showsHorizontalScrollIndicator = NO;
        _webView.scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _webView.opaque = NO;
        //垂直不显示
        //    _webView.dataDetectorTypes = UIDataDetectorTypeLink;
        //取消右侧，下侧滚动条，去处上下滚动边界的黑色背景
        _webView.backgroundColor = [UIColor clearColor];
    }
    return _webView;
}

@end
