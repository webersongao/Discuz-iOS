//
//  WebJsInteractionDelegate.h
//  BaiduShucheng
//
//  Created by zy on 15/1/10.
//
//
#import <Foundation/Foundation.h>

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