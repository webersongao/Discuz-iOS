//
//  const.h
//  DiscuzMobile
//
//  Created by ZhangJitao on 2018/2/1.
//  Copyright © 2018年 comsenz-service.com.  All rights reserved.
//

// 常量文件

typedef NS_ENUM(NSUInteger, PostType) {
    post_normal,
    post_vote,
    post_activity,
    post_debate,
};

#define KRoot_Domainkey     @"root_domain"
#define KShadowAlert_Tag    18111301 // 通用的 ShadowAletView 的弹窗默认tag
