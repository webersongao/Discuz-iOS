//
//  DZMobileCtrl+Local.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/27.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZMobileCtrl+Local.h"

NSString * const DZ_BoolNoImage = @"dz_Nosfs24Image";

@implementation DZMobileCtrl (Local)

/**
 无图模式
 @return yes 无图模式  no 有图
 */
- (BOOL)isGraphFree {
    return [[NSUserDefaults standardUserDefaults] boolForKey:DZ_BoolNoImage];
}





@end






