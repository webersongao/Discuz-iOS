//
//  DZUserDataModel.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/8.
//  Copyright © 2019年 comsenz-service.com.  All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DZUserVarModel.h"
#import "TextIconModel.h"

typedef NS_ENUM(NSUInteger, JTCenterType) {
    JTCenterTypeMy = 0,
    JTCenterTypeOther,
};

@interface DZUserDataModel : NSObject

@property (nonatomic, assign) BOOL isOther;
@property (nonatomic, strong) NSArray *ListArray;  //!< 属性注释
@property (nonatomic, strong,readonly) DZSpaceModel *spaceModel;  //!< 属性注释

- (instancetype)initWithType:(JTCenterType)type;

-(void)updateModel:(DZUserVarModel *)VarModel;

@end
