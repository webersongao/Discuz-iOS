//
//  DZShareCenter.m
//  DiscuzMobile
//
//  Created by HB on 16/11/28.
//  Copyright © 2016年 comsenz-service.com.  All rights reserved.
//

#import "DZShareCenter.h"

// share sdk
#import <ShareSDKUI/ShareSDKUI.h>
#import <ShareSDK/ShareSDK+Base.h>
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>

@implementation DZShareCenter
// 单例
+ (instancetype)shareInstance {
    static DZShareCenter *share = nil;
    static dispatch_once_t OnceToken;
    dispatch_once(&OnceToken, ^{
        share = [[DZShareCenter alloc] init];
    });
    return share;
}
// shareSDK参数配置
- (void)setupShareConfigure {

    //新版本注册方法不在需要进行 appkey的注册
    [ShareSDK registPlatforms:^(SSDKRegister *platformsRegister) {
        //QQ
        [platformsRegister setupQQWithAppId:DZ_QQ_APPID appkey:DZ_QQ_APPKEY];
        //微信
        [platformsRegister setupWeChatWithAppId:DZ_WX_APPID appSecret:DZ_WX_APPSECRET universalLink:DZ_BASEURL];
        
        [platformsRegister setupSinaWeiboWithAppkey:DZ_WB_APPID appSecret:DZ_WB_APPSECRET redirectUrl:DZ_WB_REDIRRCTURI];
    }];
}

- (void)shareText:(nonnull NSString *)text andImages:(nullable id)images andUrlstr:(nonnull NSString *)urlStr andTitle:(nonnull NSString *)title andView:(nullable UIView *)view andHUD:(nullable MBProgressHUD *)HUD {
    NSMutableDictionary *shareParems = [NSMutableDictionary dictionary];
    [shareParems SSDKSetupShareParamsByText:text images:images url:[NSURL URLWithString:urlStr] title:title type:SSDKContentTypeAuto];
    NSMutableArray *activePlatforms = [NSMutableArray arrayWithArray:[ShareSDK activePlatforms]];
    SSUIShareSheetConfiguration *config = [[SSUIShareSheetConfiguration alloc] init];
    config.style = ShareActionSheetStyleSimple;
    [ShareSDK showShareActionSheet:view customItems:activePlatforms shareParams:shareParems sheetConfiguration:config onStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
        switch (state) {
            case SSDKResponseStateBegin: {
//                if (view != nil && HUD != nil) {
//                    [Utils showHUD:@"分享中" andView:view andHUD:HUD];
//                }
                break;
            }
            case SSDKResponseStateSuccess: {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                    message:nil
                                                                   delegate:nil
                                                          cancelButtonTitle:@"确定"
                                                          otherButtonTitles:nil];
                [alertView show];
                break;
            }
            case SSDKResponseStateFail: {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                message:[NSString stringWithFormat:@"%@",error]
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil, nil];
                [alert show];
                break;
            }
            case SSDKResponseStateCancel: {
                if (view != nil && HUD != nil) {
                    [HUD hideAnimated:YES];
                }
                break;
            }
            default:
                break;
        }
        if (state != SSDKResponseStateBegin) {
            if (view != nil && HUD != nil) {
                [HUD hideAnimated:YES];
            }
            
        }
    }];
    
}

#pragma mark - qq登录
- (void)loginWithQQSuccess:(void(^_Nullable)(id _Nullable postData,id _Nullable getData))success finish:(void(^_Nullable)(void))finish {
    
    if ([ShareSDK hasAuthorized:SSDKPlatformTypeQQ]) { // 由于qq登录需要切换账号
        [ShareSDK cancelAuthorize:SSDKPlatformTypeQQ result:nil];
    }
    
    [self loginWithPlatformType:SSDKPlatformTypeQQ success:success finish:finish];
    
}

#pragma mark - 微信登录finish
- (void)loginWithWeiXinSuccess:(void(^_Nullable)(id _Nullable postData,id _Nullable getData))success finish:(void(^_Nullable)(void))finish {
    // 去授权登录
    [self loginWithPlatformType:SSDKPlatformTypeWechat success:success finish:finish];;
    
}


#pragma mark - qq登录
- (void)loginWithPlatformType:(SSDKPlatformType)platformType success:(void(^)(id postData, id getData))success finish:(void(^)(void))finish {
    
    self.bloginModel = nil;
    
    KWEAKSELF;
    [ShareSDK getUserInfo:platformType
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
               dispatch_async(dispatch_get_main_queue(), ^{
                   
                   finish?finish():nil;
                   if (state == SSDKResponseStateSuccess) {
                       // 汉字GBK编码
                       NSString *dataGBK = [user.nickname utf2gbk];
                       NSString *type = @"qq";
                       if (platformType == SSDKPlatformTypeWechat) {
                           type = @"weixin";
                       }
                       
                       if ([DataCheck isValidString:user.uid]) {
                           NSMutableDictionary *dic = @{@"openid":user.uid,
//                                                        @"type":type,
//                                                        @"username":user.nickname
                                                        }.mutableCopy;
                           
                           weakSelf.bloginModel = [DZLoginModel initWithLogintype:type andOpenid:user.uid andGbkname:dataGBK andUsername:user.nickname];
                           if ([type isEqualToString:@"weixin"]) {
                               if ([DataCheck isValidString:[user.rawData objectForKey:@"unionid"]]) {
                                   [dic setValue:[user.rawData objectForKey:@"unionid"]  forKey:@"unionid"];
                                   self.bloginModel.unionid = [user.rawData objectForKey:@"unionid"];
                               }
                           }
                           success?success(dic,@{@"type":type}):nil;
                       } else {
                           [MBProgressHUD showInfo:@"服务器繁忙请重试"];
                       }
                   }else if (state == SSDKResponseStateCancel) {
                       [MBProgressHUD showInfo:@"取消授权"];
                   }else if (state == SSDKResponseStateFail) {
                       [MBProgressHUD showInfo:@"授权失败"];
                   }else {
                       [MBProgressHUD showInfo:error.description];
                   }
               });
           }];
}

@end
