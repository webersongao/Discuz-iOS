//
//  WebLogicManager.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/29.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BookPageDataLoader;
@protocol WebLogicManagerDelegate <NSObject>

@optional
- (void)openNewControllerWithData:(id)data; //打开一个新的web页面
- (void)evaluatingJavaScriptFromString:(NSString *)javaScriptString; //执行js事件上传指定的头像等

@end

@interface WebLogicManager : NSObject

@property (nonatomic,weak) id<WebLogicManagerDelegate>delegate;

+(WebLogicManager *)sharedManager;

/**
 *NativeCall逻辑
 *
 *  @param data web传输字典
 */
-(void)webLogicNativeCallData:(NSDictionary *)data;

/**
 *JumpToView逻辑
 *
 *  @param data web传输字典
 */
-(void)webLogicJumpToViewData:(NSDictionary *)data;

/**
 *  dataDic
 */
- (NSDictionary *)webDataDictionary;

@end
