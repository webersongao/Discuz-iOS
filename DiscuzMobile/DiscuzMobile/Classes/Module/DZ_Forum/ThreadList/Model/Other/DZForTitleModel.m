//
//  DZForTitleModel.m
//  DiscuzMobile
//
//  Created by HB on 17/1/17.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import "DZForTitleModel.h"

@implementation DZForTitleModel

- (instancetype)initWithName:(NSString *)name type:(DZ_ListType)type{
    self = [super init];
    if (self) {
        self.name = name;
        self.listType = type;
    }
    return self;
}

+ (instancetype)modelName:(NSString *)name type:(DZ_ListType)type {
    DZForTitleModel *model = [[DZForTitleModel alloc] initWithName:name type:type];
    return model;
}

@end
