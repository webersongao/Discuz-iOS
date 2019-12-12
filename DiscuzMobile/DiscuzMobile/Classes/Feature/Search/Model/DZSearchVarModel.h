//
//  DZSearchVarModel.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/12.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZUserModel.h"
#import "DZNoticeModel.h"
#import "DZSearchModel.h"


@interface DZSearchVarModel : DZUserModel

//"notice": {4 items},
//"threadlist": [9 items],
//"total": "9",
//"tpp": "10"

@property (nonatomic, copy) NSString *tpp;  //!< 属性注释
@property (nonatomic, assign) NSInteger total;  //!< 属性注释
@property (nonatomic, strong) DZNoticeModel *notice;
@property (nonatomic, strong) NSArray<DZSearchModel *> *threadlist;  //!< 属性注释




@end


