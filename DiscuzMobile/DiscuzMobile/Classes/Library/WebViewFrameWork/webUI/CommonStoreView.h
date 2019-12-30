//
//  CommonStoreView.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/29.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonUIWebView.h"

@interface CommonStoreView : UIView

@property (nonatomic,strong) CommonUIWebView *contentWebView;

- (id)initWithFrame:(CGRect)frame resultDelegate:(id)resultDelegate;

- (void)reloadCurrentWebByBaseUrl:(NSString *)baseUrl;
- (void)loadViewWithUrl:(NSString*)url;
- (void)loadViewWithUrl:(NSString*)url encode:(BOOL)encode;
- (void)loadViewWithLocalPath:(NSString*)localPath;
- (void)removeFefreshHeaderView;
- (void)reloadCurrentWeb;

- (void)judgeWebViewHeightGap:(float)gapValue;

@end
