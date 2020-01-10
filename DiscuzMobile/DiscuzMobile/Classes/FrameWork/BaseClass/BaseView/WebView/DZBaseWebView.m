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
        self.UIDelegate = self;
        self.navigationDelegate = self;
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
        self.UIDelegate = self;
        self.navigationDelegate = self;
        self.CssMode = WebCSS_DeviceW;
        [self comfigBaseWebView];
    }
    return self;
}

-(void)comfigBaseWebView{
    
    self.backgroundColor = KRandom_Color;
}


#pragma mark   /********************* WKUIDelegate *************************/

- (nullable WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    return webView;
}

#pragma mark   /********************* WKNavigationDelegate *************************/

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    decisionHandler(WKNavigationActionPolicyAllow);
    DLog(@"WBS--> decidePolicyForNavigationAction");
}


- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    decisionHandler(WKNavigationResponsePolicyAllow);
    DLog(@"WBS--> decidePolicyForNavigationResponse");
}


- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    DLog(@"WBS--> didStartProvisionalNavigation");
}


- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    DLog(@"WBS--> didReceiveServerRedirectForProvisionalNavigation");
}


- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error;{
    DLog(@"WBS--> didFailProvisionalNavigation");
}


- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation{
    if ([self.WKBaseDelegate respondsToSelector:@selector(dz_mainwebView:didCommitNavigation:)]) {
        [self.WKBaseDelegate dz_mainwebView:self didCommitNavigation:navigation];
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    if ([self.WKBaseDelegate respondsToSelector:@selector(dz_mainwebView:didFinishNavigation:)]) {
        [self.WKBaseDelegate dz_mainwebView:self didFinishNavigation:navigation];
    }
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    if ([self.WKBaseDelegate respondsToSelector:@selector(dz_mainwebView:didFailNavigation:withError:)]) {
        [self.WKBaseDelegate dz_mainwebView:self didFailNavigation:navigation withError:error];
    }
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







