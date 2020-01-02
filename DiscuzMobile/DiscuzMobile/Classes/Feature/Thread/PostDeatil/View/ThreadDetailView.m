//
//  ThreadDetailView.m
//  DiscuzMobile
//
//  Created by HB on 16/11/25.
//  Copyright © 2016年 comsenz-service.com.  All rights reserved.
//

#import "ThreadDetailView.h"


#define  keyboardHeight 216
#define  toolBarHeight 40

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
    self.webView = [[WKWebView alloc] initWithFrame:self.bounds];
    self.backgroundColor = [UIColor whiteColor];
    self.webView.backgroundColor = [UIColor whiteColor];
    self.webView.scrollView.showsHorizontalScrollIndicator = NO;
    //    self.webView.delegate = self;
    self.webView.scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.webView.opaque = NO;
    //垂直不显示
//    _webView.dataDetectorTypes = UIDataDetectorTypeLink;
    //取消右侧，下侧滚动条，去处上下滚动边界的黑色背景
    _webView.backgroundColor = [UIColor clearColor];
    [_webView setContentScaleFactor:YES];
//    [_webView setScalesPageToFit:YES];
    [self addSubview:self.webView];
    
    // 创建键盘
    [self createHPGrowingTextView];
    
}



#pragma mark -  创建表情键盘
- (void)createHPGrowingTextView {
    
    [self addSubview:self.emoKeyboard];
    self.emoKeyboard.backgroundColor = K_Color_MainGray;
    self.emoKeyboard.textBarView.style = detail_textBar;
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

- (EmoticonKeyboard *)emoKeyboard {
    if (_emoKeyboard == nil) {
        _emoKeyboard = [[EmoticonKeyboard alloc] initWithFrame:CGRectMake(0, self.height - KTabbar_Height, KScreenWidth, KTabbar_Height)];
    }
    return _emoKeyboard;
}

@end
