//
//  DZLoginResModel.h
//  DiscuzMobile
//
//  Created by gensinimac1 on 15/5/7.
//  Copyright (c) 2015年 comsenz-service.com. All rights reserved.
//

#import "DZUserModel.h"
#import "DZBaseResModel.h"

@interface DZRegInputModel : NSObject

//"username": "xg5D25",
//"password": "c7PP27",
//"password2": "K8kFy7",
//"email": "k5Kmg3"

@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *password2;
@property (nonatomic, copy) NSString *email;


-(BOOL)isValidate;

@end

@interface DZLoginResModel : DZBaseResModel

@property (nonatomic, strong) DZUserModel *Variables;  //!< 属性注释

@end
