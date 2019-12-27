//
//  PostDebateModel.m
//  DiscuzMobile
//
//  Created by HB on 2017/6/26.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import "PostDebateModel.h"

@implementation PostDebateModel


- (NSDictionary *)creatDicdata:(DZSecVerifyView *)verifyView {
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithObject:[DZMobileCtrl sharedCtrl].Global.formhash forKey:@"formhash"];
    [dic setObject:self.subject forKey: @"subject"];
    [dic setObject:self.message forKey: @"message"];
    [dic setObject:self.special forKey:@"special"];
    [dic setObject:self.affirmpoint forKey:@"affirmpoint"];
    [dic setObject:self.negapoint forKey:@"negapoint"];
    [dic setObject:self.endtime forKey:@"endtime"];
    [dic setObject:self.umpire forKey:@"umpire"];
    [dic setObject:@"1" forKey:@"allownoticeauthor"];  // 设置回帖的时候提醒作者
    
    // TODO: 正确处理应该要选择主题类型
    if (self.typeId.length) {
        [dic setObject:[NSString stringWithFormat:@"%@",self.typeId] forKey:@"typeid"];
    }
    
    if (verifyView.isyanzhengma) {
        [dic setObject:verifyView.yanTextField.text forKey:@"seccodeverify"];
        [dic setObject:verifyView.secureData.sechash forKey:@"sechash"];
        if (verifyView.secureData.secqaa.length) {
            [dic setObject:verifyView.secTextField.text forKey:@"secanswer"];;
        }
    }
    
    return dic.copy;
}



@end
