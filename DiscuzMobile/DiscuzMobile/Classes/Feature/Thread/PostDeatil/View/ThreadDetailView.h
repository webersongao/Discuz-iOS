//
//  ThreadDetailView.h
//  DiscuzMobile
//
//  Created by HB on 16/11/25.
//  Copyright © 2016年 comsenz-service.com.  All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DZWebView.h"
#import "DZEmoticonKeyboard.h"
#import "DZRefreshHeader.h"
#import "DZRefreshFooter.h"

@interface ThreadDetailView : UIView

@property (nonatomic,strong) DZWebView *webView;
@property (nonatomic, strong) DZEmoticonKeyboard *emoKeyboard;

@end
