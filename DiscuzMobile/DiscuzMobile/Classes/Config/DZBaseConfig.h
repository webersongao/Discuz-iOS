//
//  BaseConfig.h
//  DiscuzMobile
//
//  Created by ZhangJitao on 2018/2/1.
//  Copyright © 2018年 comsenz-service.com.  All rights reserved.
//

// 配置文件
#ifndef BaseConfig_h
#define BaseConfig_h

#pragma mark - 不同的项目在这里配置 ========================

/*
 *  BaseUrl设置  MACRO_PRODUCT == 1为生产环境，注释为测试环境
 */

//#define MACRO_PRODUCT 1


#define DZ_COMPANYNAME  @"北京康创联盛科技有限公司" // 公司
#define DZ_APPNAME      KAppDisplayName
#define DZ_EMPTYIMAGE   @"empty_icon" // 无数据显示图片
#define DZ_LOGONAME     @"" // @"ap_name" // 登录、注册页APP名称图片
#define DZ_MAINCOLOR    mRGBColor(50, 120, 230) // 主题色 mRGBColor(220, 130, 0)
#define DZ_BBSRULE      [NSString stringWithFormat:@"bbsrule_%@",@"discuz"]; // 网站服务条款txt名字
#define DZ_INCINFO      [NSString stringWithFormat:@"©2001 - %@ comsenz-service.com.",KNowYear] // 版权时间

#ifdef MACRO_PRODUCT //线上环境
#define DZ_BASEURL      @"http://demo.516680.com/"

#else //测试环境
// 除了两个plugin.php的，别的都需要拼接 api/mobile/
#define DZ_BASEURL      @"http://demo.516680.com/"
#endif

#pragma mark   /********************* 第三方 *************************/
// QQ、微信登录和分享，自己申请的appid 和 secret 微博暂无
// QQ 
#define DZ_QQ_APPID @""
#define DZ_QQ_APPKEY @""
// 微信
#define DZ_WX_APPID @""
#define DZ_WX_APPSECRET @""

// 微博
#define DZ_WB_APPID @""
#define DZ_WB_APPSECRET @""
#define DZ_WB_REDIRRCTURI @"https://www.comsenz-service.com"

// 推送
#define DZ_PushTOKEN      @"XGTOKEN"
#define DZ_Push_APPID     2200197269
#define DZ_Push_APPKEY    @""


// 讯飞语音识别
#define DZ_iflyAppID      @"5dcbe00e"

#endif

