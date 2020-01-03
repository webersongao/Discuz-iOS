//
//  ThreadDetailView.h
//  DiscuzMobile
//
//  Created by HB on 16/11/25.
//  Copyright © 2016年 comsenz-service.com.  All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "DZEmoticonKeyboard.h"

@interface ThreadDetailView : UIView

@property (nonatomic,strong) WKWebView *webView;
@property (nonatomic, strong) DZEmoticonKeyboard *emoKeyboard;

@end
