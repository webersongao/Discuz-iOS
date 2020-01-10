//
//  WebViewBridge.h
//  WebViewBridge
//
//  Created by zy on 12-2-27.
//  Copyright (c) 2015年. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

@protocol WebviewClientExecuteable <NSObject>

@required
-(NSString*) WebviewClientExecSync:(NSString*) json withConfig:(NSDictionary*) config;
@end

@interface WebViewBridge : NSObject


- (void)setWebApiObject:(id)object;
-(BOOL) processWebviewCB:(WKWebView*) webview
				 withReq:(NSURLRequest*) request;

- (BOOL)requestIsTel:(NSURLRequest *)request;
@property (nonatomic, assign) BOOL isAllowPandaJs;  //!< 是否执行抖猫的JS

@end
