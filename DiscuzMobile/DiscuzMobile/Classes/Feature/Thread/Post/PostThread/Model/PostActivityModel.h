//
//  PostActivityModel.h
//  DiscuzMobile
//
//  Created by HB on 2017/7/4.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PostNormalModel.h"
#import "DZSecVerifyView.h"

@interface PostActivityModel : PostNormalModel

@property (nonatomic ,copy) NSString *activityClass; // 分类
@property (nonatomic ,copy) NSString *startTime; // 开始时间
@property (nonatomic ,copy) NSString *endTime;  // 结束时间
@property (nonatomic ,copy) NSString *place;   // 地点
@property (nonatomic ,copy) NSString *peopleNum; // 人数
@property (nonatomic ,strong) NSMutableArray * userArray ; // 用户自定 选项

@property (nonatomic, copy) NSString *activitycity; // 城市
@property (nonatomic, copy) NSString *gender;  // 性别
@property (nonatomic, copy) NSString *activitycredit;  // 积分
@property (nonatomic, copy) NSString *cost;   // 花销
@property (nonatomic, copy) NSString *activityexpiration;  // 截止时间

- (NSDictionary *)createActivityPostDict:(DZSecVerifyView *)verifyView;



@end
