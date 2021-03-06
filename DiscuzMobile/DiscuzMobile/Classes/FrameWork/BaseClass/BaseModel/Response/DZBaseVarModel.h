//
//  DZBaseVarModel.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/7/22.
//  Copyright © 2019 comsenz-service.com.  All rights reserved.
//

#import "DZGlobalModel.h"
#import "DZNoticeModel.h"
#import "DZGroupModel.h"

@interface DZBaseVarModel : DZGlobalModel

@property (nonatomic, copy) NSString *member_email;
@property (nonatomic, copy) NSString *member_credits;
@property (nonatomic, copy) NSString *setting_bbclosed;

@property (nonatomic, strong) DZGroupModel *group;
@property (nonatomic, strong) DZNoticeModel *notice;


@end




