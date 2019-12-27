//
//  PostActivityModel.m
//  DiscuzMobile
//
//  Created by HB on 2017/7/4.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import "PostActivityModel.h"

@implementation PostActivityModel

- (NSMutableArray *)userArray {
    if (!_userArray) {
        _userArray = [NSMutableArray array];
    }
    return _userArray;
}

- (NSDictionary *)createActivityPostDict:(DZSecVerifyView *)verifyView {
    
    NSMutableDictionary  * dic =[NSMutableDictionary dictionary];
    
    [dic setValue:[DZMobileCtrl sharedCtrl].Global.formhash forKey:@"formhash"];
    [dic setValue:self.subject forKey:@"subject"];
    [dic setValue:@"活动" forKey:@"typeid"];
    [dic setValue:self.message forKey:@"message"];
    [dic setValue:@"1" forKey:@"activitytime"];
    [dic setValue:self.activityClass forKey:@"activityclass"];
    [dic setValue:self.startTime forKey:@"starttimefrom[1]"];
    [dic setValue:@"4" forKey:@"special"];
    [dic setValue:self.endTime forKey:@"starttimeto"];
    [dic setValue:self.userArray forKey:@"userfield"];
    [dic setValue:self.place forKey:@"activityplace"];
    [dic setValue:self.peopleNum forKey:@"activitynumber"];
    [dic setValue:@"IOS" forKey:@"mobiletype" ];
    [dic setValue:self.activitycity forKey:@"activitycity"];
    [dic setValue:self.gender forKey:@"gender"];
    [dic setValue:self.activitycredit forKey:@"activitycredit"];
    [dic setValue:self.cost forKey:@"cost"];
    [dic setValue:self.activityexpiration forKey:@"activityexpiration"];
    
    
    // 设置回帖的时候提醒作者 集成推送才生效
    [dic setValue:@"1" forKey:@"allownoticeauthor"];
    
    if (self.aidArray.count) {
        if (self.aidArray.count > 0) {
            [dic setValue:[NSString stringWithFormat:@"%@",[self.aidArray objectAtIndex:0]] forKey:[NSString stringWithFormat:@"attachnew[%@][description]",[self.aidArray objectAtIndex:0]]];
        }
    }
    
    if (verifyView.isyanzhengma) {
        [dic setObject:verifyView.yanTextField.text forKey:@"seccodeverify"];
        [dic setObject:verifyView.secureData.sechash forKey:@"sechash"];
    }
    
    if ([DataCheck isValidString:self.typeId]) {
        [dic setValue:self.typeId forKey:@"typeid"];
    }
    return dic.copy;
}

@end
