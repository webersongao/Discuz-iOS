//
//  DZSelectTypeButton.h
//  DiscuzMobile
//
//  Created by HB on 2017/7/27.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DZSelectTypeButton : UIButton

@property (nonatomic, assign) BOOL isSelect;

@property (nonatomic, copy) NSString *activityKey;
@property (nonatomic, copy) NSString *activityValue;

@end
