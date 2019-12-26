//
//  DZMobileCtrl+Update.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/26.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZMobileCtrl+Update.h"

@implementation DZMobileCtrl (Update)

-(void)updateUserFormHash:(NSString *)formHash{
    if (!self.User) {
        self.User = [[DZUserModel alloc] init];
    }
    self.User.formhash = checkNull(formHash);
}

-(void)updateUserModel:(DZUserModel *)UserModel{
    if (!self.User) {
        self.User = [[DZUserModel alloc] init];
    }
    self.User.member_uid = UserModel.member_uid;
    self.User.member_username = UserModel.member_username;
    self.User.member_avatar = UserModel.member_avatar;
    self.User.formhash = UserModel.formhash;
    self.User.cookiepre = UserModel.cookiepre;
}


@end
