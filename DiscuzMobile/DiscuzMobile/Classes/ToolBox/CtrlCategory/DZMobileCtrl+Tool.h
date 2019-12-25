//
//  DZMobileCtrl+Tool.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/25.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZMobileCtrl.h"

@interface DZMobileCtrl (Tool)


+(void)addObserver:(id)observer sel:(SEL)selName name:(NSString *)name;

+(void)postNotification:(NSString *)name obj:(id)obj userinfo:(NSDictionary *)info;






@end


