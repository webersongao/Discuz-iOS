//
//  WebviewBridge.m
//  WebviewBridge
//
//  Created by zy on 12-2-27.
//  Copyright (c) 2015年. All rights reserved.
//

#import "WebviewBridge.h"
#import "WebviewApi.h"

static NSString *ClentPrefix = @"wx://pandareader/";

@interface WebviewBridge ()
@property (nonatomic,weak) WebviewApi *webViewApi;
@end

@implementation WebviewBridge

- (id)init
{
    self = [super init];
    if(self)
	{
        self.isAllowPandaJs = YES;
    }
    
    return self;
}

- (void)setWebApiObject:(id)object
{
    self.webViewApi = object;
}

- (BOOL)requestIsTel:(NSURLRequest *)request
{
    NSString* reqstr = [[request URL] absoluteString];
    if ([reqstr hasPrefix:@"tel"]) {
        return NO;
    }
    return YES;
}

-(BOOL) processWebviewCB:(WKWebView*) webview withReq:(NSURLRequest*) request
{
	if(!webview)
	{
		return NO;
	}

	NSString* reqstr = [[request URL] absoluteString];
	
	if([reqstr hasPrefix:ClentPrefix])
	{
		NSRange range = {0};
		range.location = [ClentPrefix length];
		range.length = [reqstr length] - range.location;
		NSString* json = [reqstr substringWithRange:range];
        NSString* newjson = [json stringByRemovingPercentEncoding];
        if (self.isAllowPandaJs) {
            [self startExecJson:newjson];
        }else{
            DLog(@"WBS 禁止执行JS");
        }
        return NO;
        
    } else {
        //不是抖猫自己js，后还需要做js的兼容处理比如下载等其他错误js
        return [WebviewApi handleRedirectUrl:reqstr];
    }
    
}

- (void)startExecJson:(NSString *)json
{
    if ([self.webViewApi respondsToSelector:@selector(WebviewClientExecSync:withConfig:)]) {
        [self.webViewApi WebviewClientExecSync:json withConfig:nil];
    }
}

-(void)dealloc
{
    
}
@end
