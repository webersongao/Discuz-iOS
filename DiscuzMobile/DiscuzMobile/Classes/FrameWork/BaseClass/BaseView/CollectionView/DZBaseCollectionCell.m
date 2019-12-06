//
//  DZBaseCollectionCell.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/22.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZBaseCollectionCell.h"

@implementation DZBaseCollectionCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = KRandom_Color;
    }
    return self;
}

@end
