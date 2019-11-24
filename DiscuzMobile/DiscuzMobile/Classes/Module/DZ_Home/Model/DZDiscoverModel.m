//
//  DZDiscoverModel.m
//  DiscuzMobile
//
//  Created by ZhangJitao on 2019/7/22.
//  Copyright © 2019 comsenz-service.com.  All rights reserved.
//

#import "DZDiscoverModel.h"
#import "ThreadListModel.h"

@implementation DZDiscoverModel

//+ (void)initialize
//{
//    if (self == [DZDiscoverModel class]) {
//        [DZDiscoverModel mj_setupObjectClassInArray:^NSDictionary *{
//            return @{@"data":@"ThreadListModel"};
//        }];
//    }
//}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [ThreadListModel class]};
}


@end



