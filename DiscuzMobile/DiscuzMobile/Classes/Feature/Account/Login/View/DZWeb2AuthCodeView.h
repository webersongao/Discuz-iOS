//
//  DZWeb2AuthCodeView.h
//  DiscuzMobile
//
//  Created by HB on 16/12/6.
//  Copyright © 2016年 comsenz-service.com.  All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface DZWeb2AuthCodeView : UIView

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, copy) void(^refreshAuthCodeBlock)(void);


-(void)loadRequestWithCodeUrl:(NSString *)urlString;

@end
