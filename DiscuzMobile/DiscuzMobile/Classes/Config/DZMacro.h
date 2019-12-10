//
//  DZMacro.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/6.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#ifndef DZMacro_h
#define DZMacro_h

#import "PRLayouter.h"

#pragma mark - app名称
#define KAppDisplayName [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]
#define KNowYear [[NSDate date] stringFromDateFormat:@"yyyy"]

/** App id */
#define DZAPPID @"1011658227"
#define AppStorePath @"https://itunes.apple.com/cn/app/id1011658227"

// 邮箱
#define DeveloperEmail @"zjt182163@163.com"
#define KdefaultAlert @"网络异常，请稍后重试"
#define kDeafultCover  [UIImage imageNamed:@"discuz_default"]

#define KWEAKSELF __weak typeof(self) weakSelf = self;
#define STRONGSELF __strong typeof(weakSelf) strongSelf = weakSelf;

#define KScreenBounds [[UIScreen mainScreen] bounds]
#define KWidthScale(value)  ((value)*(KScreenWidth/375))
#define KHeightScale(value) ((value)*(KScreenHeight/667))
#define KScreenWidth [UIScreen mainScreen].bounds.size.width
#define KScreenHeight [UIScreen mainScreen].bounds.size.height

#define TIME 1.0
#define ALINE 35

#define kMargin10   10.0
#define kMargin15   15.0
#define kMargin20   20.0
#define kMargin25   25.0
#define kMargin30   30.0
#define kToolBarHeight   44.0
#define kCellDefaultHeight   65.0

/**
 * iPhone X Screen Insets
 */
#define IS_iPhoneX [PRLayouter is_iPhoneX]
#define IS_Iphone4S  (KScreenHeight == 480 ? YES : NO)
#define IS_Iphone5S (KScreenHeight==568)
#define IS_Iphone6 (KScreenHeight==667)
#define IS_IphonePlus (KScreenHeight==736)
#define IS_IphoneXMax (KScreenHeight==896)
// nav
#define KStatusBarHeight [PRLayouter statusBarHeight]  //  竖屏 状态条 X: 44 N: 20
#define KNavigation_Bar_Height [PRLayouter navigation_Bar_Height_Portrait] // X: 横竖屏44 N: 横竖屏44
#define KNavi_ContainStatusBar_Height [PRLayouter navigation_Bar_ContainStatusBar_Height] // X: 竖屏88 横屏64 N: 横竖屏64
#define KNavigation_Bar_Gap  [PRLayouter navigation_Bar_Gap_2X] // X: 竖屏24
#define KContent_OringY (KNavi_ContainStatusBar_Height + 1)// vc里面内容Y坐标
#define KView_OutNavi_Bounds   CGRectMake(0,KNavi_ContainStatusBar_Height,KScreenWidth,KScreenHeight-KNavi_ContainStatusBar_Height)

// tab
#define KTabbar_Height  [PRLayouter tabbar_Height] // X: 竖屏83 横屏70
#define KTabbar_Gap  [PRLayouter tabbar_Gap_2X] // X: 竖屏34 横屏21
#define KTabbar_Gap_top  KScreenHeight - [PRLayouter tabbar_Gap_2X] //
#define KTabbar_Height_top  KScreenHeight - [PRLayouter tabbar_Height] //

#define KImageNamed(NamePointer) [UIImage imageNamed:(NamePointer)]
#define KNibName(name)   [UINib nibWithNibName:(name) bundle:[NSBundle mainBundle]]
#define KURLString(urlString) [NSURL URLWithString:[NSString stringWithFormat:@"%@",urlString]]


//G－C－D
#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)

#ifdef DEBUG
#define DLog( s, ... ) NSLog( @"<%p %@:(%d)> %@", self, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define DLog( s, ... )
#endif

// 国际化 字符创
#define _(x) [LocalStringUtil localString:x]
#define checkInteger(__X__)        [NSString stringWithFormat:@"%ld",__X__]
#define checkNull(__X__)        (__X__) == nil || [(__X__) isEqual:[NSNull null]] ? @"" : [NSString stringWithFormat:@"%@", (__X__)]

#pragma mark - 网络请求超时时间
#define TIMEOUT 30.0

// 判断系统版本
#define  iOS8   ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)
#define  iOS9   ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0)
#define  iOS10   ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0)
#define  iOS11   ([[UIDevice currentDevice].systemVersion floatValue] >= 11.0)

#define phoneScale (int)[UIScreen mainScreen].scale
#pragma mark - 判断屏幕适配 ============================================
#define iPhone320 KScreenWidth == 320
#define iPhone375 KScreenWidth == 375
#define iPhone414 KScreenWidth == 414

#define StatusBarHeight [UIApplication sharedApplication].statusBarFrame.size.height
#define SafeAreaTopHeight ((KScreenHeight >= 812.0) && [[UIDevice currentDevice].model isEqualToString:@"iPhone"] ? 88 : 64)
//#define SafeAreaBottomHeight ((KScreenHeight >= 812.0) && [[UIDevice currentDevice].model isEqualToString:@"iPhone"]  ? 30 : 0)
#define DZNetError(_domain, _code, _desc)   [NSError errorWithDomain:checkNull(_domain) code:(_code) userInfo:@{NSLocalizedFailureReasonErrorKey : (checkNull(_desc).length ? checkNull(_desc) : @"网络错误，请稍后再试")}]

typedef void(^backNoneBlock)(void);
typedef void(^backStateBlock)(id data,BOOL bSuccess);
typedef void(^backStringBlock)(NSString * String);
typedef void(^backArrayBlock)(NSArray * Array);
typedef void(^backSetBlock)(NSSet * setArr);
typedef void(^backBoolBlock)(BOOL boolState);
typedef void(^completeBoolBlock)(BOOL bSuccess);
typedef void(^backButtonBlock)(UIButton * button);
typedef void(^backDictionaryBlock)(NSDictionary * Dictionary);
typedef void(^backArraySizeBlock)(NSArray * Array,int64_t allSize);

typedef void(^completeBlock)(id data,NSError *error);
typedef void(^ProgressBlock)(double Progress,NSError *error);


#pragma mark - 通知 ================================================

// tabbar个人中心选中
#define DZ_configSelectedIndex_Notify @"selec7tIndex"
// 连续点击tabbar刷新
#define DZ_TABBARREFRESH_Notify @"TabbarButt3onClickDidRepeatNotification"
// 刷新个人中心资料
#define DZ_REFRESHCENTER_Notify     @"get6Ziliao"
#define DZ_IMAGEORNOT_Notify        @"IMGOR3NOT_Notify"
#define DZ_UserSigOut_Notify       @"SIGNOUT4NOTIFY"
// 点中statusbar
#define DZ_STATUSBARTAP_Notify @"statuBarTappedNotification"
// 防止首次加载APP的时候没有数据，划过导航页面的时候刷新一次
#define DZ_FIRSTAPP_Notify @"APPFIRSTLanch"

// 首次请求帖子列表的时候通知
#define DZ_ThreadListFirstReload_Notify @"THREADLIST3FISTREQUEST"
// 使用DZContainerController控件，请求的时候
#define DZ_CONTAINERQUEST_Notify @"DZCONTAINERQUEST"

// 登录后刷新一些页面，获取cookie或者formhash
#define DZ_LoginedRefreshInfo_Notify @"LOGINEndRefreshGetInfo"
#define COLLECTIONFORUMREFRESH @"COLLECTIO6NFORUMREFRESH"
#define DZ_RefreshWeb_Notify @"refreshL9ocalWeb"

#define DZ_DomainUrlChange_Notify @"DomainN4ameChange"
#define DZ_UserLogin_Notify @"user9LoginNotification"

#endif /* DZMacro_h */
