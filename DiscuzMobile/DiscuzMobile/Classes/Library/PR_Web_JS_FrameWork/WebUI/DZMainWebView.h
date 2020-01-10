//
//  DZMainWebView.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/29.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DZWebView.h"

@interface DZMainWebView : UIView

@property (nonatomic,strong) DZWebView *contentWebView;

- (void)reloadCurrentWebByBaseUrl:(NSString *)baseUrl;
- (void)loadViewWithUrl:(NSString*)url;
- (void)loadViewWithUrl:(NSString*)url encode:(BOOL)encode;
- (void)loadViewWithLocalPath:(NSString*)localPath;
- (void)removeFefreshHeaderView;
- (void)reloadCurrentWeb;

- (void)judgeWebViewHeightGap:(float)gapValue;

@end
