//
//  PostVoteModel.m
//  DiscuzMobile
//
//  Created by HB on 2017/6/26.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import "PostVoteModel.h"

@implementation PostVoteModel

- (NSMutableArray *)polloptionArr {
    if (!_polloptionArr) {
        _polloptionArr = [NSMutableArray array];
    }
    return _polloptionArr;
}

- (NSMutableArray *)aidArray {
    if (!_aidArray) {
        _aidArray = [NSMutableArray array];
    }
    return _aidArray;
}

- (NSMutableArray *)checkArr {
    if (!_checkArr) {
        _checkArr = [NSMutableArray array];
    }
    return _checkArr;
}

- (NSDictionary *)creatVoteDictdata:(DZSecVerifyView *)verifyView voteArr:(NSArray *)voteArr{
    // post需传值 formhash subject标题 typeid message帖子内容 没有内容就填写nil attachnew[aid][description] mobiletype allowlocal allowsound allowphoto location special maxchoices expiration
    NSMutableDictionary  * postDic =[NSMutableDictionary dictionary ];
    // 设置回帖的时候提醒作者
    [postDic setValue:@"1" forKey:@"allownoticeauthor"];
    [postDic setValue:[DZMobileCtrl sharedCtrl].Global.formhash forKey:@"formhash"];
    [postDic setValue:self.subject forKey:@"subject"];
    [postDic setValue:self.message forKey:@"message"];
    [postDic setValue:self.selectNum forKey:@"maxchoices"];                 //最大可选项数
    [postDic setValue:(self.isVisibleResult?@"1":@"0") forKey:@"visibilitypoll"]; //是否投票可见
    [postDic setValue:(self.isVisibleParticipants?@"1":@"0") forKey:@"overt"];   //是否公开投票参与人
    [postDic setValue:self.polloptionArr forKey:@"polloption"];                  //选项内容 数组 模式
    [postDic setValue:self.dayNum forKey:@"expiration"];  //过期时间
    [postDic setValue:@"1" forKey:@"special"];
    if (verifyView.isyanzhengma)
    {
        [postDic setObject:verifyView.yanTextField.text forKey:@"seccodeverify"];
        [postDic setObject:verifyView.secureData.sechash forKey:@"sechash"];
    }
    
    if ([DataCheck isValidString:self.typeId]) {
        [postDic setValue:self.typeId forKey:@"typeid"];
    }
    
    if (voteArr.count > 0) {
        [postDic setValue:voteArr forKey:@"pollimage"];
    }
    return postDic.copy;
}

@end
