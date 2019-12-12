//
//  DZFavThreadVarModel.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/12.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZUserModel.h"

@interface DZFavThreadItem : NSObject


@end

@interface DZFavThreadVarModel : DZUserModel

@property (nonatomic, strong) NSArray *list;  //!< 属性注释
@property (nonatomic, assign) NSInteger count;  //!< 属性注释
@property (nonatomic, assign) NSInteger perpage;  //!< 属性注释



@end




