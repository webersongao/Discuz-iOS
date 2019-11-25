//
//  ChatContainScrollView.m
//  DiscuzMobile
//
//  Created by HB on 17/4/27.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import "ChatContainScrollView.h"

@implementation ChatContainScrollView


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}


@end
