//
//  CenterManageModel.h
//  DiscuzMobile
//
//  Created by HB on 2017/9/8.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DZUserVarModel.h"
@class TextIconModel;

typedef NS_ENUM(NSUInteger, JTCenterType) {
    JTCenterTypeMy = 0,
    JTCenterTypeOther,
};

@interface CenterManageModel : NSObject

@property (nonatomic, strong) NSMutableArray<TextIconModel *> *useArr;  // 他人中心用
@property (nonatomic, assign) BOOL isOther;

// 公用
@property (nonatomic, strong) DZUserVarModel *userVarModel;  //!< 属性注释
@property (nonatomic, strong) NSMutableArray<TextIconModel *> *manageArr;
@property (nonatomic, strong) NSMutableArray<TextIconModel *> *infoArr;

- (instancetype)initWithType:(JTCenterType)type;

@end
