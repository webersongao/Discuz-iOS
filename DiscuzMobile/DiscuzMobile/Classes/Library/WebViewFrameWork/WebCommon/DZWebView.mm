//
//  DZWebView.m
//  ebook
//
//  Created by zy
//  Copyright (c) 2015年. All rights reserved.
//
#import "DZWebView.h"
#import "WebviewBridge.h"
#import "DZLoadingAnimationView.h"

#import "PRNetWorkErrorView.h"
#import "DZRefreshHeader.h"

#define REFRESH_OFFSET 50
#define PUSH_OFFSET 10
@interface DZWebView  ()<PRNetWorkErrorViewDelegate,UIScrollViewDelegate>
{
    BOOL webIsReloading;
    DZLoadingAnimationView * _actView;
}
@property (nonatomic,strong) NSURL *failedUrl;
@property(nonatomic, assign) int resourceCount;
@property(nonatomic, assign) int resourceCompletedCount;
@property(nonatomic, copy) NSString *lastLoadUrl;
@property (nonatomic,strong) PRNetWorkErrorView *errorView;
@property (nonatomic, weak) DZRefreshHeader *refreshHeader;

@end


@implementation DZWebView

@synthesize IydDelegate;
@synthesize pWebapi;
@synthesize urlLoad;
@synthesize resourceCount;
@synthesize resourceCompletedCount;

- (id)initWithFrame:(CGRect)frame configuration:(nonnull WKWebViewConfiguration *)configuration
{
    self = [super initWithFrame:frame configuration:configuration];
    if (self) {
        // Initialization code
        self.opaque = NO;
        self.isAjax = YES;
        self.navigationDelegate = self;
        self.backgroundColor = [UIColor whiteColor];
        
        bridge = [[WebviewBridge alloc]init];
        pWebapi = [[WebviewApi alloc] init];
        [bridge setWebApiObject:pWebapi];
        
        [self initCenterLoadingView];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadLastUrl) name:@"webViewUrl" object:nil];
    }
    
    return self;
}

/*如果没有下拉刷新，是否控制web滚动到边界的时候就停止
 *
 */
- (void)setScroller:(BOOL)canScro
{
    self.scrollView.bounces = canScro;
}

-(void)setIsAjax:(BOOL)isAjax{
    _isAjax = isAjax;
    bridge.isAllowPandaJs = isAjax;
}

/*根据页面添加是否需要下拉刷新
 *
 */
- (void)refrshViewInitWithInsertFlag:(BOOL)insertFlag
{
    DZRefreshHeader *refreshHeader = [DZRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshAction) mode:DZRefreshHeaderModeDefault];
    self.scrollView.mj_header = refreshHeader;
    self.refreshHeader = refreshHeader;
}

- (void)refreshAction
{
    webIsReloading = YES;
    [self startLoadRequest:self.urlLoad];
}

- (void)checkRestartLoadingAnimation
{
    if (self.refreshHeader) {
        [self.refreshHeader checkRestartLoadingAnimation];
    }
}

- (void)doneLoadingTableViewData
{
    webIsReloading = NO;
    
    if (self.refreshHeader.isRefreshing) {
        [self.refreshHeader endRefreshing];
    }
}

/**
 *  loading view 中间
 */
- (void)initCenterLoadingView
{
    _actView = [[DZLoadingAnimationView alloc] initWithSuperView:self loadingType:PRLoadingViewNoramlType];
}

- (void)stopActIndicatorAnimating
{
    
    [_actView stopAnimationView];
}

- (void)completeProgress
{
    if (_actView) {
        [self stopActIndicatorAnimating];
    }
}

- (void)setProgress:(float)progress
{
    
}

-(void)startLoadRequest:(NSString *)urlStr
{
    if (self.isLoading) {
        [self stopLoading];
    }
    [self loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
    
}

-(void)startLoadRequestWithLocalPath:(NSString *)localPath
{
    if (self.isLoading) {
        [self stopLoading];
    }
    [self loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:localPath]]];
}

- (NSString*)addPublicParamToWebUrl:(NSString*)webUrl encode:(BOOL)needEncode
{
    //添加必要的参数
    NSString* webUrlEncoded = nil;
    if (needEncode)
    {
        NSString* webUrlUtf8 = nil;
        webUrlUtf8 = [webUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        webUrlEncoded = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,  (CFStringRef)webUrlUtf8, NULL,(CFStringRef)@"!*'();:@&=+$,/?%#[]",kCFStringEncodingUTF8));
        self.urlLoad = webUrlUtf8;
        return webUrlEncoded;
    }
    else
    {
        //对地址进行utf8的encode，处理中文的时候
        //阅读器跳转到评论时,web锚点为"#comment",这时候不需要编码,否则锚点失效,其实URL进行正常编码
        if ([webUrl hasSuffix:@"#comment"]){
            webUrlEncoded = [webUrl stringByAppendingString:@""];
        } else {
            webUrlEncoded = [webUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }
        
        self.urlLoad = webUrlEncoded;
        return webUrlEncoded;
    }
}

- (void)reloadLastUrl
{
    if (self.lastLoadUrl) {
        [self startLoadRequest:self.lastLoadUrl];
    }
}

- (void)removeRefreshHeaderView
{
    if (self.refreshHeader) {
        self.refreshHeader.hidden = YES;
    }
}

/**
 *  失败页重试按钮代理方法
 */
- (void)tryAgainButtonDidClicked
{
    [self.errorView removeFromSuperview];
    [_actView startAnimationViewWithSuperView:self];
    [self reloadBtn];
    
}

- (void)removeErrorView
{
    if (_errorView)
    {
        [_errorView removeFromSuperview];
        self.errorView = nil;
    }
}

- (void)reloadBtn
{
    if ([DZMobileCtrl connectedNetwork]) {
        [self startLoadRequest:self.urlLoad];
        return;
    } else {
        //防止没网络的情况下,点"重试"页面变白
        [self handleFailureWebView];
        [_actView stopAnimationView];
        return;
    }
}

#pragma mark -- 内存优化
- (void)optimizeWebMemory
{
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"WebKitCacheModelPreferenceKey"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitDiskImageCacheEnabled"];//自己添加的，原文没有提到。
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitOfflineWebApplicationCacheEnabled"];//自己添加的，原文没有提到。
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)dealloc
{
    //内存优化
    if (self.isLoading) {
        [self stopLoading];
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"webViewUrl" object:nil];
}


#pragma mark -- WKNavigationDelegate
/*
 WKNavigationDelegate主要处理一些跳转、加载处理操作，WKUIDelegate主要处理JS脚本，确认框，警告框等
 */
// 根据WebView对于即将跳转的HTTP请求头信息和相关信息来决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    if ([self.IydDelegate respondsToSelector:@selector(commonUIWebViewShouldStartLoadWithData:)])
    {
        [self.IydDelegate performSelector:@selector(commonUIWebViewShouldStartLoadWithData:) withObject:nil];
    }
    
    [self removeErrorView];
    
    NSString * urlStr = navigationAction.request.URL.absoluteString;
    BOOL allowAjax = [bridge processWebviewCB:webView withReq:navigationAction.request];
    if(allowAjax){
        BOOL isTel = [bridge requestIsTel:navigationAction.request];
        if (isTel) {
            self.lastLoadUrl = urlStr;
        }
        decisionHandler(WKNavigationActionPolicyAllow);
    }else{
        decisionHandler(WKNavigationActionPolicyCancel);
    }
}

// 根据客户端受到的服务器响应头以及response相关信息来决定是否可以跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    //允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationResponsePolicyCancel);
}

// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
    if (!webIsReloading)
        [_actView startAnimationViewWithSuperView:self];
    
    if ([self.IydDelegate respondsToSelector:@selector(commonUIWebViewDidStartLoad)])
    {
        [self.IydDelegate performSelector:@selector(commonUIWebViewDidStartLoad) withObject:nil];
    }
    
}

// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    [self stopActIndicatorAnimating];
    
    /**
     *  记录当前的url
     */
    self.lastLoadUrl = nil;
    self.urlLoad = webView.URL.absoluteString;
    
    /**
     *  屏蔽掉长摁出现的编辑菜单
     */
    [webView evaluateJavaScript:@"document.documentElement.style.webkitUserSelect='none';" completionHandler:nil];
    [webView evaluateJavaScript:@"document.documentElement.style.webkitTouchCallout='none';" completionHandler:nil];
    
    /**
     *
     *  回调给外层逻辑处理
     */
    if ([self.IydDelegate respondsToSelector:@selector(updateWebViewTitle:)])
    {
        __weak DZWebView *weakWeb = self;
        [webView evaluateJavaScript:@"document.title" completionHandler:^(id _Nullable title, NSError * _Nullable error) {
            if (!error && [title isKindOfClass:[NSString class]]) {
                //获取webview的title
                //----修改"来源"乱码bug---
                NSString* webViewTitle = [NSString decodeString:title];
                [weakWeb.IydDelegate performSelector:@selector(updateWebViewTitle:) withObject:webViewTitle];
            }
        }];
    }
    
    if ([self.IydDelegate respondsToSelector:@selector(commonUIWebViewDidFinishLoad:)])
    {
        [self.IydDelegate performSelector:@selector(commonUIWebViewDidFinishLoad:) withObject:nil];
    }
    
    /**
     *  refresh消失
     */
    [self doneLoadingTableViewData];
    
    
    /*
     *内存优化
     */
    [self optimizeWebMemory];
    
}

// 接收到服务器跳转请求即服务重定向时之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    
    DLog(@"load fail domain=%@,error_code=%ld",error.domain,(long)error.code);
    [self stopActIndicatorAnimating];
    
    if ([self.IydDelegate respondsToSelector:@selector(commonUIWebViewDidFailLoad)]) {
        [self.IydDelegate performSelector:@selector(commonUIWebViewDidFailLoad) withObject:nil];
    }
    
    [self doneLoadingTableViewData];
    
    if (error.code == NSURLErrorCancelled) {
        return; // this is Error -999
    } else {
        NSString *errorFailingURLStringKey = [error.userInfo stringForKey:@"NSErrorFailingURLStringKey"];
        if ([errorFailingURLStringKey hasPrefix:@"http"]) {
            if ([self.IydDelegate respondsToSelector:@selector(updateWebViewTitle:)]) {
                [self.IydDelegate performSelector:@selector(updateWebViewTitle:) withObject:@"网络连接失败"];
            }
            [self handleFailureWebView];
        }
    }
}

-(void)handleFailureWebView
{
    [self addErrorView];
}

- (PRNetWorkErrorView *)errorView
{
    if (!_errorView) {
        CGRect errorRect = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
        _errorView = [[PRNetWorkErrorView alloc] initWithFrame:errorRect viewType:PRErrorViewNoNet];
        _errorView.delegate = self;
    }
    return _errorView;
}

//加载失败页 PRErrorViewType
- (void)addErrorView {
    [self.errorView addErrorViewWithViewType:PRErrorViewNoNet];
    [self addSubview:self.errorView];
}

//提交发生错误时调用
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    
    [self stopActIndicatorAnimating];
    
    if ([self.IydDelegate respondsToSelector:@selector(commonUIWebViewDidFailLoad)]) {
        [self.IydDelegate performSelector:@selector(commonUIWebViewDidFailLoad) withObject:nil];
    }
    
    [self doneLoadingTableViewData];
    
    if ([self.IydDelegate respondsToSelector:@selector(updateWebViewTitle:)]) {
        [self.IydDelegate performSelector:@selector(updateWebViewTitle:) withObject:@"网页提交错误"];
    }
}

//进程被终止时调用
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView{
    
}


@end
