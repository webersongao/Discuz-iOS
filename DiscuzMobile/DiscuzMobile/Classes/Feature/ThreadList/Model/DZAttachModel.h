//
//  DZAttachModel.h
//  DiscuzMobile
//
//  Created by ZhangJitao on 2019/7/22.
//  Copyright © 2019 comsenz-service.com.  All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DZAttachModel : NSObject
@property (nonatomic, copy) NSString *aid;
@property (nonatomic, copy) NSString *tid;
@property (nonatomic, copy) NSString *pid;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *dateline;
@property (nonatomic, copy) NSString *attachment;
@property (nonatomic, copy) NSString *thumb;
@property (nonatomic, copy) NSString *readperm;
@property (nonatomic, copy) NSString *type;
@end

NS_ASSUME_NONNULL_END
