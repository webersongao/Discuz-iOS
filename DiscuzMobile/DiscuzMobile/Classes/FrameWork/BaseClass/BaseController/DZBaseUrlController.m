//
//  DZBaseUrlController.m
//  DiscuzMobile
//
//  Created by HB on 16/4/29.
//  Copyright © 2016年 comsenz-service.com. All rights reserved.
//

#import "DZBaseUrlController.h"
#import "UIAlertController+Extension.h"

@interface DZBaseUrlController ()<DZBaseWebViewDelegate>

@property (nonatomic,strong) DZBaseWebView *webView;
@end

@implementation DZBaseUrlController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:DZ_StatusBarTap_Notify object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.webView];
    
    KWEAKSELF
    [_webView loadBaseWebUrl:_urlString back:^(NSString *String) {
        [UIAlertController alertTitle:nil message:String controller:self doneText:@"返回" cancelText:nil doneHandle:^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        } cancelHandle:nil];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusBarTappedAction:) name:DZ_StatusBarTap_Notify object:nil];
}

- (void)dz_mainwebView:(DZBaseWebView *)webView didLoadMainTitle:(NSString *)title{
    [self setTitle:title];
}

- (void)dz_mainwebView:(DZBaseWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation{
    [self.HUD showLoadingMessag:@"正在加载" toView:self.view];
}


- (void)dz_mainwebView:(DZBaseWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:webView.URL];
    NSEnumerator *enumerator = [cookies objectEnumerator];
    NSHTTPCookie *cookie;
    while (cookie = [enumerator nextObject]) {
        DLog(@"WBS -- COOKIE{name: %@, value: %@}", [cookie name], [cookie value]);
    }
    [self.HUD hideAnimated:YES];
}

- (void)dz_mainwebView:(DZBaseWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    [self.HUD hideAnimated:YES];
    if (error.code == NSURLErrorCancelled) {
        //忽略这个错误。
        return ;
    }
    [_webView setHidden:YES];
    [UIAlertController alertTitle:nil message:[error localizedDescription] controller:self doneText:@"返回" cancelText:nil doneHandle:^{
        [self.navigationController popViewControllerAnimated:YES];
    } cancelHandle:nil];
}

// 点击状态栏到顶部
- (void)statusBarTappedAction:(NSNotification*)notification {
    [self.webView.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (DZBaseWebView *)webView {
    if (_webView == nil) {
        _webView = [[DZBaseWebView alloc] initWithFrame:KView_OutNavi_Bounds];
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.userInteractionEnabled = YES;
        _webView.WKBaseDelegate = self;
        [_webView setOpaque:NO];
    }
    return _webView;
}

@end
