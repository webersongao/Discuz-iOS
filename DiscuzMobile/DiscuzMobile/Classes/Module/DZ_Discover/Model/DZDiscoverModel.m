//
//  DZDiscoverModel.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/22.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZDiscoverModel.h"

@implementation DZDiscoverModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"catlist" : [DZForumNodeModel class],
             @"forumlist" : [DZBaseForumModel class]
    };
}

-(instancetype)formartForumNodeData{
   
    
    
    
    
    return self;
}

@end
