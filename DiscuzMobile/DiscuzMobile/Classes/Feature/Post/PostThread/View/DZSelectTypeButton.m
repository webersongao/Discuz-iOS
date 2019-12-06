//
//  DZSelectTypeButton.m
//  DiscuzMobile
//
//  Created by HB on 2017/7/27.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import "DZSelectTypeButton.h"

@implementation DZSelectTypeButton

- (void)setIsSelect:(BOOL)isSelect {
    _isSelect = isSelect;
    if (isSelect) {
        [self setBackgroundColor:K_Color_Theme];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } else {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}


@end
