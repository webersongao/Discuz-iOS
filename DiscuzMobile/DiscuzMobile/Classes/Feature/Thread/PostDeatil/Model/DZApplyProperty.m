//
//  DZApplyProperty.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/10.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZApplyProperty.h"

@implementation DZApartInItem

- (instancetype)initWithTitle:(NSString *)title Value:(NSString *)value
{
    self = [super init];
    if (self) {
        self.title = checkNull(title);
        self.value = checkNull(value);
    }
    return self;
}
@end
