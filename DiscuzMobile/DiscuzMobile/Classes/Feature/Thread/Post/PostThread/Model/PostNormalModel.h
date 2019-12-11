//
//  PostNormalModel.h
//  DiscuzMobile
//
//  Created by HB on 2017/6/26.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DZSecVerifyView.h"
#import "DZNormalThreadToolCell.h"

@interface PostNormalModel : NSObject

@property (nonatomic, copy) NSString *subject;     // 标题
@property (nonatomic, copy) NSString *message;     // 详细
@property (nonatomic, strong) NSMutableArray *aidArray;

@property (nonatomic, copy) NSString *typeId;     // 选择类型

- (NSDictionary *)creatNormalDictdata:(DZSecVerifyView *)verifyView toolCell:(DZNormalThreadToolCell *)toolCell;


@end
