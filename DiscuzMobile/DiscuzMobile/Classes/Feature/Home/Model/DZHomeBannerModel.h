//
//  DZHomeBannerModel.h
//  DiscuzMobile
//
//  Created by HB on 16/4/18.
//  Copyright © 2016年 comsenz-service.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DZHomeBannerModel : NSObject

@property (nonatomic, copy) NSString *imagefile; // 图片路径 有的时候优先取
@property (nonatomic,copy) NSString *imageurl;  // 图片路径
@property (nonatomic,copy) NSString *link;    // 点击图片链接
@property (nonatomic,copy) NSString *title;  // 标题
@property (nonatomic,copy) NSString *tid;    // 帖子tid
@property (nonatomic, copy) NSString *link_type;

+ (NSArray *)setBannerData:(id)responseObject;

@end
