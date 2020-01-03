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
#define K00BF99_Color  @"#00BF99" //绿色
#define K2A2C2F_Color  @"#2A2C2F" //tabbar 黑色

#define KLine_Color  @"#f5f5f5" //分割线



#define KF5F6F8_Color  @"#F5F6F8"
#define K9A9AA7_Color  @"#9A9AA7"
#define K4D5663_Color  @"#4D5663"
#define K33C3A5_Color  @"#33C3A5"
#define K3A434E_Color  @"#3A434E"
#define KD8D8D8_Color  @"#D8D8D8"
#define KF6F7F8_Color  @"#F6F7F8"
#define KF7F7F7_Color  @"#F7F7F7"
#define KF7F8F9_Color  @"#F7F8F9"
#define KD0D0D0_Color  @"#D0D0D0"
#define K31323E_Color  @"#31323E"
#define K6A6C7A_Color  @"#6A6C7A"
#define KE2E2E5_Color  @"#E2E2E5"
#define KEBF9F6_Color  @"#EBF9F6"
#define KFF7634_Color  @"#FF7634"
#define K535B65_Color  @"#535B65"
#define KAAAAAA_Color  @"#AAAAAA"
#define K8E97A4_Color  @"#8E97A4"
#define KBABCC4_Color  @"#BABCC4"
#define KECECEC_Color  @"#ECECEC"
#define KF63737_Color  @"#F63737"
#define KD3D3D3_Color  @"#D3D3D3"
#define K888888_Color  @"#888888"
#define KEEEEEE_Color  @"#EEEEEE"
#define KEFF1F4_Color  @"#EFF1F4"
#define KEBF9F6_Color  @"#EBF9F6"
#define KE2E4EB_Color  @"#E2E4EB"
#define K85682F_Color  @"#85682F"
#define K8F88FF_Color  @"#8F88FF"
#define K8B93A0_Color  @"#8B93A0"
#define KF4E3C5_Color  @"#F4E3C5"
#define KF7CC7A_Color  @"#F7CC7A"
#define KFFEEC5_Color  @"#FFEEC5"
#define KE2E4EB_Color  @"#E2E4EB"
#define KEFEFEF_Color  @"#EFEFEF"
#define KC4C4CC_Color  @"#C4C4CC"
#define KEE1111_Color  @"#EE1111"
#define K42423F_Color  @"#42423F"
#define K212120_Color  @"#212120"
#define KF4E3C5_Color  @"#F4E3C5"
#define KFFB734_Color  @"#FFB734"
#define KFA3A3A_Color  @"#FA3A3A"
#define KBD4BFF_Color  @"#BD4BFF"
#define KFF9234_Color  @"#FF9234"
#define K1E1E1E_Color  @"#1E1E1E"
#define K696565_Color  @"#696565"
#define K8C581E_Color  @"#8C581E"
#define KFFF9F2_Color  @"#FFF9F2"
#define KD0AC86_Color  @"#D0AC86"
#define K7B4411_Color  @"#7B4411"
#define KFFE1C1_Color  @"#FFE1C1"
#define KFFEFDE_Color  @"#FFEFDE"
#define KFFB46F_Color  @"#FFB46F"
#define KFF3B00_Color  @"#FF3B00"
#define K8C68EA_Color  @"#8C68EA"
#define K7E5DD2_Color  @"#7E5DD2"
#define K837CFF_Color  @"#837CFF"
#define KB436FE_Color  @"#B436FE"
#define K4D4D4D_Color  @"#4D4D4D"
#define K21201F_Color  @"#21201F"
#define K222222_Color  @"#222222"
#define K555555_Color  @"#555555"
#define KFF9234_Color  @"#FF9234"
#define KFA3A3A_Color  @"#FA3A3A"
#define K464646_Color  @"#464646"
#define K333333_Color  @"#333333"
#define K4A4A4A_Color  @"#4A4A4A"
#define KFEFEFE_Color  @"#FEFEFE"

#define K241217_Color  @"#241217"




#define KFont(fontSize)                     [UIFont systemFontOfSize:fontSize]
#define KBoldFont(fontSize)                 [UIFont boldSystemFontOfSize:fontSize]
#define KFontWeight(fontSize, fontWeight)   [UIFont systemFontOfSize:fontSize weight:fontWeight]
#define KExtraBoldFont(fontSize)            [UIFont systemFontOfSize:fontSize weight:UIFontWeightMedium]



#endif /* Color_h */
