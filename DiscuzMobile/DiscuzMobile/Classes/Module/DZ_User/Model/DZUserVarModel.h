//
//  DZUserVarModel.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/2.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZBaseVarModel.h"
#import "DZSpaceModel.h"
#import "DZBaseResModel.h"

@interface DZUserVarModel : DZBaseVarModel

@property (nonatomic, strong) DZSpaceModel *space;  //!< 属性注释
@property (nonatomic, strong) NSDictionary<NSString *,NSDictionary *> *extcredits;  //!< 属性注释

@end



@interface DZUserResModel : DZBaseResModel

@property (nonatomic, strong) DZUserVarModel *Variables;  //!< 属性注释

@end


//@interface DZExtItemModel : NSObject
//
////"img": "",
////"title": "威望",
////"unit": "",
////"ratio": "0",
////"showinthread": null,
////"allowexchangein": null,
////"allowexchangeout": null
//
//@property (nonatomic, copy) NSString *img;  //!< 属性注释
//@property (nonatomic, copy) NSString *title;  //!< 属性注释
//@property (nonatomic, copy) NSString *unit;  //!< 属性注释
//@property (nonatomic, copy) NSString *ratio;  //!< 属性注释
//@property (nonatomic, copy) NSString *showinthread;  //!< 属性注释
//@property (nonatomic, copy) NSString *allowexchangein;  //!< 属性注释
//@property (nonatomic, copy) NSString *allowexchangeout;  //!< 属性注释
//
//
//@end
