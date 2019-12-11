//
//  DZPostNetTool.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/27.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DZBaseAuthModel.h"
#import "DZPostVarModel.h"
#import "DZPollVarModel.h"
#import "ThreadModel.h"

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

// 查看投票详情
-(void)DZ_DownloadVoteOptionsDetail:(NSString *)tid pollid:(NSString *)pollid success:(void(^)(DZVoteResModel *voteModel))success;

//获取帖子详情
-(void)DZ_DownloadPostDetail:(NSString *)tid Page:(NSInteger)page success:(void(^)(DZPosResModel *varModel,NSDictionary *resDict,NSError *error))success;

// 发布帖子
+ (void)DZ_PublistPostThread:(NSString *)fid postDict:(NSDictionary *)postDict completion:(void(^)(DZBaseResModel *resModel,NSString *tidStr,NSError *error))completion;

/// 取消活动
+ (void)DZ_CancelPostedActivity:(NSString *)tid Thread:(ThreadModel *)threadModel completion:(void(^)(DZBaseResModel *resModel,NSError *error))completion;


/// 发布帖子 回复（回帖）
+ (void)DZ_SendPostReply:(NSDictionary *)dict completion:(void(^)(DZBaseResModel *resModel,NSError *error))completion;

/// 参与投票
+(void)DZ_PubLishVoteWithData:(id)data fid:(NSString *)fid tid:(NSString *)tid completion:(void(^)(DZBaseResModel *resModel,NSError *error))completion;

/// 获取引用的回复 （带有Html标签）
+ (void)DZ_ReferenceReply:(NSString *)dataStr tid:(NSString *)tid completion:(void(^)(DZBaseResModel *resModel,NSString * notice,NSError *error))completion;


/// 参与活动
+ (void)DZ_APPlyActivity:(NSDictionary *)paraDict getDict:(NSDictionary *)getDict completion:(void(^)(DZBaseResModel *resModel,NSError *error))completion;

// 活动管理 （批准，删除等操作）
+ (void)DZ_ManageActivity:(NSString *)tid reason:(NSString *)reason operation:(NSString *)operation applyid:(NSString *)applyid completion:(void(^)(DZBaseResModel *resModel,NSError *error))completion;

@end
