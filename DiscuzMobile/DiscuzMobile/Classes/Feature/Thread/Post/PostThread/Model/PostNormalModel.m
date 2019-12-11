//
//  PostNormalModel.m
//  DiscuzMobile
//
//  Created by HB on 2017/6/26.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import "PostNormalModel.h"
#import "AudioTool.h"
#import "AudioModel.h"

@implementation PostNormalModel

- (NSMutableArray *)aidArray {
    if (_aidArray == nil) {
        _aidArray = [NSMutableArray array];
    }
    return _aidArray;
}


- (NSDictionary *)creatNormalDictdata:(DZSecVerifyView *)verifyView toolCell:(DZNormalThreadToolCell *)toolCell{
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithObject:[DZMobileCtrl sharedCtrl].User.formhash forKey:@"formhash"];
    
    [dic setObject:self.subject forKey:@"subject"];
    [dic setObject:self.message forKey:@"message"];
    [dic setObject:@"1" forKey:@"allownoticeauthor"];  // 设置回帖的时候提醒作者
    
    // TODO: 正确处理应该要选择主题类型
    if ([DataCheck isValidString:self.typeId]) {
        [dic setObject:[NSString stringWithFormat:@"%@",self.typeId] forKey:@"typeid"];
    }
    
    if (verifyView.isyanzhengma) {
        [dic setObject:verifyView.yanTextField.text forKey:@"seccodeverify"];
        [dic setObject:verifyView.secureData.sechash forKey:@"sechash"];
        if (verifyView.secureData.secqaa.length) {
            [dic setObject:verifyView.secTextField.text forKey:@"secanswer"];;
        }
    }
    
    if ([AudioTool shareInstance].audioArray.count > 0) {
        for (int i = 0; i < [AudioTool shareInstance].audioArray.count; i ++) {
            AudioModel *audio = [[AudioTool shareInstance].audioArray objectAtIndex:i];
            NSString *description = [NSString stringWithFormat:@"%ld",(long)audio.time];
            [dic setObject:description forKey:[NSString stringWithFormat:@"attachnew[%@][description]",audio.audioUploadId]];
        }
    }
    
    if (toolCell.uploadView.uploadModel.aidArray.count > 0) {
        for (int i=0; i < toolCell.uploadView.uploadModel.aidArray.count; i++) {
            NSString *description = @"";
            [dic setObject:description forKey:[NSString stringWithFormat:@"attachnew[%@][description]",[toolCell.uploadView.uploadModel.aidArray objectAtIndex:i]]];
        }
        [dic setObject:@"1" forKey:@"allowphoto"];
    }
    return dic;
    
}



@end
