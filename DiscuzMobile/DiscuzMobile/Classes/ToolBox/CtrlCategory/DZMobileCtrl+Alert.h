//
//  DZMobileCtrl+Alert.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/21.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZMobileCtrl.h"

NS_ASSUME_NONNULL_BEGIN

@interface DZMobileCtrl (Alert)


+ (void)showAlertError:(NSString *)error;

+ (void)showALertSuccess:(NSString *)success;

+ (void)showAlertWarn:(NSString *)warn;

+ (void)showAlertInfo:(NSString *)info;



@end

NS_ASSUME_NONNULL_END
