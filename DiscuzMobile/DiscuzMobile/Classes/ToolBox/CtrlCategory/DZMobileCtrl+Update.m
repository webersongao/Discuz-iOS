//
//  DZMobileCtrl+Update.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/26.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZMobileCtrl+Update.h"

@implementation DZMobileCtrl (Update)

-(void)updateGlobalFormHash:(NSString *)formHash{
    if (!self.Global) {
        self.Global = [[DZGlobalModel alloc] init];
    }
    self.Global.formhash = checkNull(formHash);
}

-(void)updateGlobalModel:(DZGlobalModel *)GlobalModel{
    if (!self.Global) {
        self.Global = [[DZGlobalModel alloc] init];
    }
    self.Global.member_uid = GlobalModel.member_uid;
    self.Global.member_username = GlobalModel.member_username;
    self.Global.member_avatar = GlobalModel.member_avatar;
    self.Global.formhash = GlobalModel.formhash;
    self.Global.cookiepre = GlobalModel.cookiepre;
}


@end
