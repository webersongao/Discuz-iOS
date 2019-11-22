//
//  DiscoverModel.m
//  DiscuzMobile
//
//  Created by ZhangJitao on 2019/7/22.
//  Copyright © 2019 comsenz-service.com.  All rights reserved.
//

#import "DiscoverModel.h"
#import "ThreadListModel.h"

@implementation DiscoverModel

//+ (void)initialize
//{
//    if (self == [DiscoverModel class]) {
//        [DiscoverModel mj_setupObjectClassInArray:^NSDictionary *{
//            return @{@"data":@"ThreadListModel"};
//        }];
//    }
//}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [ThreadListModel class]};
}
@end
