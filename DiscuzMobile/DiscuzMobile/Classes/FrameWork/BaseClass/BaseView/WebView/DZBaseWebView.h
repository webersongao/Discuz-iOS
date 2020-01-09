//
//  DZBaseWebView.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2020/1/3.
//  Copyright © 2020 comsenz-service.com. All rights reserved.
//

#import <WebKit/WebKit.h>

typedef enum : NSUInteger {
    WebCSS_Default,
    WebCSS_DeviceW, /// 使用设备宽度 铺满父控件
} WebCSSMode;

@interface DZBaseWebView : WKWebView

- (instancetype)initDeviceModeWithFrame:(CGRect)frame;

@end

