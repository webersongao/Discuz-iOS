//
//  DZBaseWebView.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2020/1/3.
//  Copyright © 2020 comsenz-service.com. All rights reserved.
//

#import <WebKit/WebKit.h>
#import "DZWebUrlHelper.h"
#import <WebViewJavascriptBridge.h>

typedef enum : NSUInteger {
    WebCSS_Default,
    WebCSS_DeviceW, /// 使用设备宽度 铺满父控件
} WebCSSMode;

@class DZBaseWebView;
@protocol DZBaseWebViewDelegate <NSObject>

@optional


- (void)dz_mainwebView:(DZBaseWebView *)webView didLoadMainTitle:(NSString *)title;

- (BOOL)dz_mainwebView:(DZBaseWebView *)webView didDecidePolicy:(WKNavigationAction *)navigationAction;

- (void)dz_mainwebView:(DZBaseWebView *)webView didStartNavigation:(null_unspecified WKNavigation *)navigation;

- (void)dz_mainwebView:(DZBaseWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation;

- (void)dz_mainwebView:(DZBaseWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation;

- (void)dz_mainwebView:(DZBaseWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error;

@end


@interface DZBaseWebView : WKWebView

@property(nullable,nonatomic,weak) id<DZBaseWebViewDelegate>  WKBaseDelegate;

- (instancetype)initDeviceModeWithFrame:(CGRect)frame;

- (void)dz_loadBaseWebUrl:(NSString *)urlString back:(backStringBlock)backBlock;

- (void)dz_registerHandler:(NSString*)handlerName handler:(WVJBHandler)handler;

@end

