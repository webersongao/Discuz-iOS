//
//  webviewApi.m
//  ebook
//
//  Created by zy on 12-2-27.
//  Copyright (c) 2015年. All rights reserved.
//

#import "WebviewApi.h"
//#import "StringUtils.h"

 static NSString *AppstoreDownLoadUrl = @"http://itunes.apple";
 static NSString *AppstoreDownLoadHttpsUrl = @"https://itunes.apple";

@implementation WebviewApi

@synthesize delegate;

//当webview接到了js交互消息的时候，会回调给这里
//json格式基本都是 {"apiName":"xxx", "params":{xxxxx}}
-(NSString*)WebviewClientExecSync:(NSString*) json withConfig:(NSDictionary*) config
{
    NSData *string = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    id rootData = [NSJSONSerialization JSONObjectWithData:string options:NSJSONReadingMutableLeaves error:&error];
    if (rootData) {
        if ([rootData isKindOfClass:[NSDictionary class]]) {
            [self webViewClientCallBackEventHandle:rootData];
        } else if ([rootData isKindOfClass:[NSArray class]]) {
            for (NSDictionary *data in rootData) {
                [self webViewClientCallBackEventHandle:data];
            }
        }
    }
    return @"";
}

- (void)webViewClientCallBackEventHandle:(NSDictionary *)rootData
{
    
    NSString* apiName = [rootData objectForKey:@"apiName"];
    
    if ([apiName isEqualToString:@"openSysApp"])
    {
        NSDictionary* params = [rootData objectForKey:@"params"];
        NSString* appName = [params objectForKey:@"appName"];
        if ([appName isEqualToString:@"browser"])
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[params objectForKey:@"url"]]];
        }
    }
    else if([apiName isEqualToString:@"view_to"])
    {
        if ([self.delegate respondsToSelector:@selector(jumpToView:)])
        {
            [self.delegate performSelector:@selector(jumpToView:) withObject:rootData];
        }
    }
    else if([apiName isEqualToString:@"link_to"])
    {
        NSDictionary* params = [rootData objectForKey:@"params"];
        
        if ([self.delegate respondsToSelector:@selector(linkToView:)])
        {
            [self.delegate performSelector:@selector(linkToView:) withObject:params];
        }
    }
    else if ([apiName isEqualToString:@"native_call"])
    {
        [self handleNativeCallFuncDictionary:rootData];
    }
    else if ([apiName isEqualToString:@"book_down"])
    {
        NSDictionary* params = [rootData objectForKey:@"params"];
        
        if ([self.delegate respondsToSelector:@selector(startDownloadBook:)])
        {
            [self.delegate performSelector:@selector(startDownloadBook:) withObject:params];
        }
    }
    else if ([apiName isEqualToString:@"goback"])
    {
        if ([self.delegate respondsToSelector:@selector(webViewGoBack:)])
        {
            [self.delegate performSelector:@selector(webViewGoBack:) withObject:nil];
        }
    }
}


- (void)handleNativeCallFuncDictionary:(NSDictionary *)rootData
{
    NSString* appFunc = [[rootData objectForKey:@"params"] objectForKey:@"appFunc"];
    if ([appFunc isEqualToString:@"show_toast"]) {
        //弹出框特殊统一判断处理由于后台apiName不改的原因
        if ([self.delegate respondsToSelector:@selector(nativeCallShowToast:funcHandle:)]) {
            [self.delegate nativeCallShowToast:rootData funcHandle:@""];
        }
    } else if ([appFunc isEqualToString:@"on_page_finished"]){
        //页面加载完成
        if ([self.delegate respondsToSelector:@selector(webLoadFinished)]) {
            [self.delegate webLoadFinished];
        }
    } else if ([appFunc isEqualToString:@"update_page_title"]){
        //更新title
        if ([self.delegate respondsToSelector:@selector(updatePageTitleName:)]) {
            [self.delegate updatePageTitleName:rootData];
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(nativeCall:funcHandle:)])
        {
            [self.delegate performSelector:@selector(nativeCall:funcHandle:) withObject:rootData withObject:@""];
        }
    }

}

+ (BOOL)isAppOpenUrl:(NSString*)url
{
    BOOL isAppUrl = NO;
    if (url.length >= AppstoreDownLoadUrl.length && [url hasPrefix:AppstoreDownLoadUrl])
    {
        isAppUrl = YES;
    }
    else if (url.length >= AppstoreDownLoadHttpsUrl.length && [url hasPrefix:AppstoreDownLoadHttpsUrl])
    {
        isAppUrl = YES;
    }
    return isAppUrl;
}

+ (BOOL)handleRedirectUrl:(NSString *)url
{
    if ([WebviewApi isAppOpenUrl:url])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
        return NO;
    }
    
    return YES;
}

- (void)dealloc
{
}
@end
