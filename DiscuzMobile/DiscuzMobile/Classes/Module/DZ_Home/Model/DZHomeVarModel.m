//
//  DZHomeVarModel.m
//  DiscuzMobile
//
//  Created by ZhangJitao on 2019/7/22.
//  Copyright © 2019 comsenz-service.com.  All rights reserved.
//

#import "DZHomeVarModel.h"
#import "DZThreadListModel.h"

@implementation DZHomeVarModel

//+ (void)initialize
//{
//    if (self == [DZHomeVarModel class]) {
//        [DZHomeVarModel mj_setupObjectClassInArray:^NSDictionary *{
//            return @{@"data":@"DZThreadListModel"};
//        }];
//    }
//}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [DZThreadListModel class]};
}


@end



