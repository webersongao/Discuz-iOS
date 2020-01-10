//
//  DZBaseWebView.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2020/1/3.
//  Copyright © 2020 comsenz-service.com. All rights reserved.
//

#import "DZBaseWebView.h"

@interface DZBaseWebView ()<WKNavigationDelegate,WKUIDelegate>

@property(nonatomic,assign) WebCSSMode CssMode;

@end

@implementation DZBaseWebView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.CssMode = WebCSS_Default;
        [self comfigBaseWebView];
    }
    return self;
}

- (instancetype)initDeviceModeWithFrame:(CGRect)frame
{
    WKWebViewConfiguration * wkWebConfig = [self baseWebViewConfig];
    self = [super initWithFrame:frame configuration:wkWebConfig];
    if (self) {
        self.CssMode = WebCSS_DeviceW;
        [self comfigBaseWebView];
    }
    return self;
}

-(void)comfigBaseWebView{
    self.UIDelegate = self;
    self.navigationDelegate = self;
    self.backgroundColor = KRandom_Color;
}

- (void)loadBaseWebUrl:(NSString *)urlString back:(backStringBlock)backBlock{
    // 无数据的时候显示
    if (![urlString isUrlContainDomain]) {
        backBlock ? backBlock(@"请求地址不存在") : nil;
        return;
    }
    NSURL *url = [NSURL URLWithString:[NSString encodeString:urlString]];
    [self loadRequest:[NSURLRequest requestWithURL:url]];
}


#pragma mark   /********************* WKUIDelegate *************************/

- (nullable WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    return webView;
}

#pragma mark   /********************* WKNavigationDelegate *************************/
/*
 WKNavigationDelegate主要处理一些跳转、加载处理操作，WKUIDelegate主要处理JS脚本，确认框，警告框等
 */
// 根据WebView对于即将跳转的HTTP请求头信息和相关信息来决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    if ([self.WKBaseDelegate respondsToSelector:@selector(dz_mainwebView:didDecidePolicy:)]) {
        BOOL isAllow = [self.WKBaseDelegate dz_mainwebView:self didDecidePolicy:navigationAction];
        WKNavigationActionPolicy naviPolicy = isAllow ? WKNavigationActionPolicyAllow : WKNavigationActionPolicyCancel;
        decisionHandler(naviPolicy);
        return;
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

// 根据客户端受到的服务器响应头以及response相关信息来决定是否可以跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    decisionHandler(WKNavigationResponsePolicyAllow);
}

// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    if ([self.WKBaseDelegate respondsToSelector:@selector(dz_mainwebView:didStartNavigation:)]) {
        [self.WKBaseDelegate dz_mainwebView:self didStartNavigation:navigation];
    }
}

// 接收到服务器跳转请求即服务重定向时之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    DLog(@"WBS--> didReceiveServerRedirectForProvisionalNavigation");
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error;{
    
    if (error.code == NSURLErrorCancelled) {
        return; // this is Error -999
    } else {
        NSString *errorFailingURLStringKey = [error.userInfo stringForKey:@"NSErrorFailingURLStringKey"];
        if ([errorFailingURLStringKey hasPrefix:@"http"]) {
            if ([self.WKBaseDelegate respondsToSelector:@selector(dz_mainwebView:didLoadMainTitle:)]) {
                [self.WKBaseDelegate dz_mainwebView:self didLoadMainTitle:@"网页连接失败"];
            }
            /// 可以这里 添加一个失败错误页
        }
    }
}

// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation{
    if ([self.WKBaseDelegate respondsToSelector:@selector(dz_mainwebView:didCommitNavigation:)]) {
        [self.WKBaseDelegate dz_mainwebView:self didCommitNavigation:navigation];
    }
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    if ([self.WKBaseDelegate respondsToSelector:@selector(dz_mainwebView:didFinishNavigation:)]) {
        [self.WKBaseDelegate dz_mainwebView:self didFinishNavigation:navigation];
    }
    /// 屏蔽掉长摁出现的编辑菜单
    [webView evaluateJavaScript:@"document.documentElement.style.webkitUserSelect='none';" completionHandler:nil];
    [webView evaluateJavaScript:@"document.documentElement.style.webkitTouchCallout='none';" completionHandler:nil];
    
    //  回调给外层逻辑处理
    if ([self.WKBaseDelegate respondsToSelector:@selector(dz_mainwebView:didLoadMainTitle:)]) {
        [webView evaluateJavaScript:@"document.title" completionHandler:^(id _Nullable title, NSError * _Nullable error) {
            if (!error && [title isKindOfClass:[NSString class]]) {
                NSString* webViewTitle = [NSString decodeString:title];
                [self.WKBaseDelegate dz_mainwebView:self didLoadMainTitle:webViewTitle];
            }
        }];
    }
}
//提交发生错误时调用
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    if ([self.WKBaseDelegate respondsToSelector:@selector(dz_mainwebView:didFailNavigation:withError:)]) {
        [self.WKBaseDelegate dz_mainwebView:self didFailNavigation:navigation withError:error];
    }
    
    if ([self.WKBaseDelegate respondsToSelector:@selector(dz_mainwebView:didLoadMainTitle:)]) {
        [self.WKBaseDelegate dz_mainwebView:self didLoadMainTitle:@"网页提交错误"];
    }
}

//进程被终止时调用
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView{
    
}

#pragma mark   /********************* 交互逻辑 *************************/
- (void)dealloc{
    [self loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@""]]];
    [self cleanWebChache];
}

- (void)cleanWebChache {
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"WebKitCacheModelPreferenceKey"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitDiskImageCacheEnabled"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitOfflineWebApplicationCacheEnabled"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


#pragma mark   /********************* 初始化配置 *************************/

-(WKWebViewConfiguration *)baseWebViewConfig{
    NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
    [wkUController addUserScript:wkUScript];
    WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
    wkWebConfig.userContentController = wkUController;
    return wkWebConfig;
}


@end







