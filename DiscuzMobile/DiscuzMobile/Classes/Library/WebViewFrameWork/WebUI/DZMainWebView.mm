//
//  DZMainWebView.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/29.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZMainWebView.h"
#import "WebLogicManager.h"
#import "DZBaseViewController.h"

@interface DZMainWebView () <CommenUIWebViewDelegate,WebJsInteractionDelegate,WebLogicManagerDelegate>

@end

@implementation DZMainWebView

- (void)dealloc
{
    WebLogicManager *webLogicManager = [WebLogicManager sharedManager];
    webLogicManager.delegate = nil;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self webViewInit];
    }
    return self;
}

- (void)webViewInit
{
    //创建网页配置对象
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    // 创建设置对象
    WKPreferences *preference = [[WKPreferences alloc]init];
    //最小字体大小 当将javaScriptEnabled属性设置为NO时，可以看到明显的效果
    preference.minimumFontSize = 0;
    //设置是否支持javaScript 默认是支持的
    preference.javaScriptEnabled = YES;
    // 在iOS上默认为NO，表示是否允许不经过用户交互由javaScript自动打开窗口
    preference.javaScriptCanOpenWindowsAutomatically = YES;
    config.preferences = preference;
    // 是使用h5的视频播放器在线播放, 还是使用原生播放器全屏播放
    config.allowsInlineMediaPlayback = YES;
    
    self.contentWebView = [[DZWebView alloc]initWithFrame:self.bounds configuration:config];
    _contentWebView.pWebapi.delegate = self;
    _contentWebView.IydDelegate = self;
    [_contentWebView refrshViewInitWithInsertFlag:[self isShouldWebRefreshHeaderContentInsertSetting]];
    [self addSubview:_contentWebView];
}

- (void)judgeWebViewHeightGap:(float)gapValue
{
    if (self.contentWebView && gapValue > 0) {
        self.contentWebView.height = self.bounds.size.height - gapValue;
    }
}

- (BOOL)isShouldWebRefreshHeaderContentInsertSetting
{
    return NO;
}

- (void)removeFefreshHeaderView
{
    if (self.contentWebView) {
        [self.contentWebView removeRefreshHeaderView];
    }
}
- (void)loadViewWithUrl:(NSString*)url
{
    url =[_contentWebView addPublicParamToWebUrl:url encode:NO]; //统一在这里编码中文
    [_contentWebView startLoadRequest:url];
}

- (void)loadViewWithLocalPath:(NSString*)localPath
{
    //本地html一律禁止下拉刷新
    [self removeFefreshHeaderView];
    if (localPath) {
        [_contentWebView startLoadRequestWithLocalPath:localPath];
    }
}

- (void)loadViewWithUrl:(NSString*)url encode:(BOOL)encode
{
    if (encode) {
        url =[_contentWebView addPublicParamToWebUrl:url encode:NO]; //统一在这里编码中文
        [_contentWebView startLoadRequest:url];
    } else {
        _contentWebView.urlLoad = url;
        [_contentWebView startLoadRequest:url];
    }
}

- (void)reloadCurrentWebByBaseUrl:(NSString *)baseUrl
{
    if ([_contentWebView.urlLoad hasPrefix:baseUrl]) {
        [_contentWebView reload];
    }
    
    NSArray *preUrlArray = [_contentWebView.urlLoad componentsSeparatedByString:@"?"];
    NSArray *currentUrlarray = [baseUrl componentsSeparatedByString:@"?"];
    
    if (preUrlArray.count && currentUrlarray.count && [_contentWebView.urlLoad hasPrefix:currentUrlarray[0]]) {
        if (currentUrlarray.count == 2) {
            NSString *preUrl = preUrlArray[0];
            NSString *paramsUrl = currentUrlarray[1];
            NSString *url = [NSString stringWithFormat:@"%@?%@",preUrl,paramsUrl];
            [self loadViewWithUrl:url];
            
        } else {
            [_contentWebView reload];
        }
    }
}

- (void)reloadCurrentWeb
{
    if (_contentWebView.isLoading) {
        [_contentWebView stopLoading];
    }
    [_contentWebView reload];
}

#pragma mark --WebJsInteractionDelegate
- (void)jumpToView:(NSDictionary*)data
{
    WebLogicManager *webLogicManager = [WebLogicManager sharedManager];
    webLogicManager.delegate = self;
    [webLogicManager webLogicJumpToViewData:data];
}

- (void)nativeCall:(NSDictionary*)data funcHandle:(NSString*)handleID
{
    WebLogicManager *webLogicManager = [WebLogicManager sharedManager];
    webLogicManager.delegate = self;
    [webLogicManager webLogicNativeCallData:data];
}

-(void)nativeCallShowToast:(NSDictionary *)data funcHandle:(NSString *)handleID
{
    NSDictionary *params = [[data dictionaryForKey:@"params"] dictionaryForKey:@"data"];
    NSString *msg = [[params stringForKey:@"msg"] stringByReplacingOccurrencesOfString:@"/n" withString:@"\n"];
    if (msg&&msg.length) {
        [DZMobileCtrl showAlertInfo:msg];
    }
    
}

- (void)webLoadFinished
{
    [_contentWebView completeProgress];
}

- (void)updatePageTitleName:(NSDictionary *)data
{
    
}

#pragma mark -- CommenUIWebViewDelegate
- (void)updateWebViewTitle:(id)data
{
    DZBaseViewController *viewController = (DZBaseViewController*)self.viewController;
    if (viewController && [viewController isKindOfClass:[DZBaseViewController class]]) {
        if (data) {
            [viewController setTitle:data];
        }
    }
}

#pragma mark -- WebLogicManagerDelegate
- (void)evaluatingJavaScriptFromString:(NSString *)javaScriptString
{
    [self.contentWebView evaluateJavaScript:javaScriptString completionHandler:nil];
}

/** 如果weblogic有回掉进来
 *  打开一个新的web页面
 *  如果有不同的处理务必建个子类覆盖这方法处理不要写到这里面
 *  @param data  ss
 */
- (void)openNewControllerWithData:(id)data
{
    NSString *url = [data stringForKey:@"url"];
    [[DZMobileCtrl sharedCtrl] PushToWebViewController:url];
}





@end











