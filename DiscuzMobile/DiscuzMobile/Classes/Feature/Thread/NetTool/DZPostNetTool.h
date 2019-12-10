//
//  DZPostNetTool.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/27.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DZBaseAuthModel.h"

typedef NS_ENUM(NSUInteger, DZAttacheType) {
    DZAttacheImage,
    DZAttacheVote,
    DZAttacheAudio,
    DZAttacheCustom,
};

@interface DZPostNetTool : NSObject

+ (instancetype)sharedTool;
@property (nonatomic, strong) NSDictionary *uploadErrorDic;

/**
 上传附件，图片、录音
 
 @param attachArr 附件数组
 @param attacheType 附件类型
 @param getDic get参数
 @param postDic post参数
 @param complete 完成回调
 @param success 成功回调
 @param failure 失败回调
 */
- (void)DZ_UpLoadAttachmentArr:(NSArray *)attachArr attacheType:(DZAttacheType)attacheType getDic:(NSDictionary *)getDic postDic:(NSDictionary *)postDic complete:(void(^)(void))complete success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;


/// 判断是否有发帖权限
- (void)DZ_CheckUserPostAuth:(NSString *)fid success:(void(^)(DZBaseAuthModel *authModel))success;

// 帖子举报
-(void)DZ_ThreadReport:(NSString *)threadId reportMsg:(NSString *)msg fid:(NSString *)fid success:(void(^)(BOOL isSucc))success;




@end
