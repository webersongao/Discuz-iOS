//
//  DZPollVarModel.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/10.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZGlobalModel.h"
#import "DZBaseUser.h"
#import "DZBaseResModel.h"

@interface DZPollviewvote : NSObject

@property (nonatomic, strong) NSArray<DZBaseUser *> *voterlist;  //!< 属性注释
@property (nonatomic, strong) NSArray *polloptions;  //!< 属性注释


@end


@interface DZPollVarModel : DZGlobalModel

@property (nonatomic, strong) DZPollviewvote *viewvote;  //!< 属性注释



@end


@interface DZVoteResModel : DZBaseResModel

@property (nonatomic, strong) DZPollVarModel *Variables;  //!< 属性注释



@end
