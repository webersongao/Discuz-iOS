//
//  DZBaseNavigationController.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/12.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DZBaseNavigationController : UINavigationController

/**
 是否开启左滑返回手势
 */
@property (nonatomic, assign) BOOL popGestureEnabled;

@end

NS_ASSUME_NONNULL_END
