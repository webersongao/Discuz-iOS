//
//  WebViewApi.h
//  ebook
//
//  Created by zy on 12-2-27.
//  Copyright (c) 2015年. All rights reserved.
//

#import "WebViewBridge.h"

@protocol WebJsInteractionDelegate <NSObject>

@optional

- (void)jumpToView:(NSDictionary*)data;
- (void)linkToView:(NSDictionary*)data;
- (void)nativeCall:(NSDictionary*)data funcHandle:(NSString*)handleID;
- (void)nativeCallShowToast:(NSDictionary*)data funcHandle:(NSString*)handleID;
- (void)startDownloadBook:(NSDictionary*)data;
- (void)webViewGoBack:(NSDictionary*)data;
- (void)webLoadFinished;
- (void)updatePageTitleName:(NSDictionary *)data;

@end

//WebViewApi用来和webview进行交互的实体工作类
//内部处理了很多的apiName，通过delegate通知给具体的某个ui
@interface WebViewApi : NSObject<WebviewClientExecuteable>

@property(weak,nonatomic) id<WebJsInteractionDelegate> delegate;

+ (BOOL)handleRedirectUrl:(NSString *)url;
+ (BOOL)isAppOpenUrl:(NSString*)url;

@end
