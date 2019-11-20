//
//  DZNoticeModel.h
//  DiscuzMobile
//
//  Created by ZhangJitao on 2019/7/22.
//  Copyright © 2019 comsenz-service.com.  All rights reserved.
//

#import "DZBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DZNoticeModel : DZBaseModel
@property (nonatomic, copy) NSString *newpush;
@property (nonatomic, copy) NSString *newpm;
@property (nonatomic, copy) NSString *newprompt;
@property (nonatomic, copy) NSString *newmypost;
@end

NS_ASSUME_NONNULL_END
