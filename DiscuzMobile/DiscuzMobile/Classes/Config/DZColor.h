//
//  Color.h
//  DiscuzMobile
//
//  Created by ZhangJitao on 2018/2/1.
//  Copyright © 2018年 comsenz-service.com.  All rights reserved.
//

// 颜色文件
#ifndef Color_h
#define Color_h

#define mRGBColor(r, g, b)   [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define RGBACOLOR(r,g,b,a)   [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define KRandom_Color        mRGBColor(arc4random_uniform(256),arc4random_uniform(256),arc4random_uniform(256))
#define KColor(colorName,alphaValue)  [UIColor color16WithHexString:colorName alpha:alphaValue]

#define K_Color_btn_user     [UIColor whiteColor]
#define K_Color_NaviButton   DZ_MAINCOLOR
#define K_Color_Theme        DZ_MAINCOLOR
#define K_Color_NaviBar      [UIColor whiteColor]
#define K_Color_NaviTitle    DZ_MAINCOLOR
#define K_Color_MainTitle    mRGBColor(51, 51, 51)
#define K_Color_LightText    mRGBColor(153, 153, 153)
#define K_Color_MainGray     mRGBColor(238, 238, 238)
#define K_Color_Line         mRGBColor(238, 238, 238)
#define K_Color_NaviBack     mRGBColor(190, 190, 190)
#define K_Color_Message      mRGBColor(102,102,102)
#define K_Color_DarkText     mRGBColor(83,83,83)
#define K_Color_ForumGray    mRGBColor(239, 240, 241)

#define K_Color_ToolBack     mRGBColor(209, 213, 218)
#define K_Color_ToolBar      mRGBColor(236, 236, 236)
#define K_Color_Disabled     mRGBColor(190, 190, 190)


#define KFFCE2E_Color  @"#FFCE2E" //黄色
#define KFD8D2F_Color  @"#FD8D2F"
#define K2D3035_Color  @"#2D3035"
#define K8D8E91_Color  @"#8D8E91"
#define KFFFFFF_Color  @"#FFFFFF" // 白
#define KFF6565_Color  @"#FF6565"
#define KF0F0F0_Color  @"#F0F0F0"
#define K000000_Color  @"#000000" //黑
#define KBDC0C6_Color  @"#BDC0C6" // 按钮禁用
#define KECECEC_Color  @"#ECECEC" // 分割线
#define KF7F7F8_Color  @"#F7F7F8" // 点击高亮色
#define KCDCDCD_Color  @"#CDCDCD"
#define KFCA43B_Color  @"#FCA43B"
#define K2A2C2F_Color  @"#2A2C2F" //tabbar 黑色

#define KLine_Color  @"#f5f5f5" //分割线



//#define PRFFFFFF_ViewColor  @"#FFFFFF"
//#define PR000000_ViewColor  @"#000000"
//#define PRF5F6F8_ViewColor  @"#F5F6F8"
//#define PR9A9AA7_ViewColor  @"#9A9AA7"
//#define PR4D5663_ViewColor  @"#4D5663"
//#define PR33C3A5_ViewColor  @"#33C3A5"
//#define PR3A434E_ViewColor  @"#3A434E"
//#define PRD8D8D8_ViewColor  @"#D8D8D8"
//#define PRF6F7F8_ViewColor  @"#F6F7F8"
//#define PRF7F7F7_ViewColor  @"#F7F7F7"
//#define PRF7F8F9_ViewColor  @"#F7F8F9"
//#define PRD0D0D0_ViewColor  @"#D0D0D0"
//#define PR31323E_ViewColor  @"#31323E"
//#define PR6A6C7A_ViewColor  @"#6A6C7A"
//#define PRE2E2E5_ViewColor  @"#E2E2E5"
//#define PREBF9F6_ViewColor  @"#EBF9F6"
//#define PRFF7634_ViewColor  @"#FF7634"
//#define PR535B65_ViewColor  @"#535B65"
//#define PRAAAAAA_ViewColor  @"#AAAAAA"
//#define PR8E97A4_ViewColor  @"#8E97A4"
//#define PRBABCC4_ViewColor  @"#BABCC4"
//#define PRECECEC_ViewColor  @"#ECECEC"
//#define PRF63737_ViewColor  @"#F63737"
//#define PRD3D3D3_ViewColor  @"#D3D3D3"
//#define PR888888_ViewColor  @"#888888"
//#define PREEEEEE_ViewColor  @"#EEEEEE"
//#define PREFF1F4_ViewColor  @"#EFF1F4"
//#define PREBF9F6_ViewColor  @"#EBF9F6"
//#define PRE2E4EB_ViewColor  @"#E2E4EB"
//#define PR85682F_ViewColor  @"#85682F"
//#define PR8F88FF_ViewColor  @"#8F88FF"
//#define PR8B93A0_ViewColor  @"#8B93A0"
//#define PRF4E3C5_ViewColor  @"#F4E3C5"
//#define PRF7CC7A_ViewColor  @"#F7CC7A"
//#define PRFFEEC5_ViewColor  @"#FFEEC5"
//#define PRE2E4EB_ViewColor  @"#E2E4EB"
//#define PREFEFEF_ViewColor  @"#EFEFEF"
//#define PRC4C4CC_ViewColor  @"#C4C4CC"
//#define PREE1111_ViewColor  @"#EE1111"
//#define PR42423F_ViewColor  @"#42423F"
//#define PR212120_ViewColor  @"#212120"
//#define PRF4E3C5_ViewColor  @"#F4E3C5"
//#define PRFFB734_ViewColor  @"#FFB734"
//#define PRFA3A3A_ViewColor  @"#FA3A3A"
//#define PRBD4BFF_ViewColor  @"#BD4BFF"
//#define PRFF9234_ViewColor  @"#FF9234"
//#define PR1E1E1E_ViewColor  @"#1E1E1E"
//#define PR696565_ViewColor  @"#696565"
//#define PR8C581E_ViewColor  @"#8C581E"
//#define PRFFF9F2_ViewColor  @"#FFF9F2"
//#define PRD0AC86_ViewColor  @"#D0AC86"
//#define PR7B4411_ViewColor  @"#7B4411"
//#define PRFFE1C1_ViewColor  @"#FFE1C1"
//#define PRFFEFDE_ViewColor  @"#FFEFDE"
//#define PRFFB46F_ViewColor  @"#FFB46F"
//#define PRFF3B00_ViewColor  @"#FF3B00"
//#define PR8C68EA_ViewColor  @"#8C68EA"
//#define PR7E5DD2_ViewColor  @"#7E5DD2"
//#define PR837CFF_ViewColor  @"#837CFF"
//#define PRB436FE_ViewColor  @"#B436FE"
//#define PR4D4D4D_ViewColor  @"#4D4D4D"
//#define PR21201F_ViewColor  @"#21201F"
//#define PR222222_ViewColor  @"#222222"
//#define PR555555_ViewColor  @"#555555"
//#define PRFF9234_ViewColor  @"#FF9234"
//#define PRFA3A3A_ViewColor  @"#FA3A3A"
//#define PR464646_ViewColor  @"#464646"
//#define PR333333_ViewColor  @"#333333"
//#define PR4A4A4A_ViewColor  @"#4A4A4A"
//#define PRFEFEFE_ViewColor  @"#FEFEFE"

#define K241217_Color  @"#241217"




#define KFontWeight(fontSize, fontWeight) [UIFont systemFontOfSize:fontSize weight:fontWeight]
#define KFont(fontSize)             [UIFont systemFontOfSize:fontSize]
#define KBoldFont(fontSize)         [UIFont boldSystemFontOfSize:fontSize]
#define KExtraBoldFont(fontSize)    [UIFont systemFontOfSize:fontSize weight:UIFontWeightMedium]



#endif /* Color_h */
