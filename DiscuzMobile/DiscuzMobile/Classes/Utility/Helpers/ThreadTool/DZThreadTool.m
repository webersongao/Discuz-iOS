//
//  DZThreadTool.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2020/1/3.
//  Copyright © 2020 comsenz-service.com. All rights reserved.
//

#import "DZThreadTool.h"
#import "DZPostNetTool.h"
#import "UIAlertController+Extension.h"

@implementation DZThreadTool

+(void)PostComplainWithCtrl:(UIViewController *)Ctrl jvbaoId:(NSString *)jvbaoId fid:(NSString *)fid{
    
    [UIAlertController alertTitle:@"举报"
                          message:nil
                       controller:Ctrl
                      doneTextArr:@[@"广告垃圾",@"违规内容",@"恶意灌水",@"重复发帖"]
                       cancelText:@"取消"
                       doneHandle:^(NSInteger index) {
        switch (index) {
            case 0:
                [self.class createPostjb:@"广告垃圾" jubaoPid:jvbaoId fid:fid];
                break;
            case 1:
                [self.class createPostjb:@"违规内容" jubaoPid:jvbaoId fid:fid];
                break;
            case 2:
                [self.class createPostjb:@"恶意灌水" jubaoPid:jvbaoId fid:fid];
                break;
            case 3:
                [self.class createPostjb:@"重复发帖" jubaoPid:jvbaoId fid:fid];
                break;
            default:
                break;
        }
    } cancelHandle:^{
        
    }];
}

#pragma mark - 提交举报
+(void)createPostjb:(NSString *)str jubaoPid:(NSString *)strjubao fid:(NSString *)fid{
    
    [[DZPostNetTool sharedTool] DZ_ThreadReport:strjubao reportMsg:str fid:fid success:^(BOOL isSucc) {
        if (isSucc) {
            [DZMobileCtrl showAlertInfo:@"提交成功！"];
        }else{
            [DZMobileCtrl showAlertInfo:@"提交失败，请稍后再试"];
        }
    }];
}

@end
