//
//  UILabel+TopTitle.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/23.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, AttchPosition) {
    P_before,
    P_after
};

@interface UILabel (TopTitle)

- (void)setText:(NSString *)text andImageName:(NSString *)imageName andSize:(CGSize)size andPosition:(AttchPosition)position;

- (void)setText:(NSString *)text andImage:(UIImage *)image andSize:(CGSize)size andPosition:(AttchPosition)position;

@end


