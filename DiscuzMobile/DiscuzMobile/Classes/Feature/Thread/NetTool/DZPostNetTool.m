//
//  DZPostNetTool.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/27.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZPostNetTool.h"
#import "UIImage+Limit.h"
#import "DZBaseResModel.h"

@implementation DZPostNetTool

+ (instancetype)sharedTool {
    static DZPostNetTool *upTool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        upTool = [[DZPostNetTool alloc] init];
    });
    return upTool;
}

- (void)DZ_UpLoadAttachmentArr:(NSArray *)attachArr attacheType:(DZAttacheType)attacheType getDic:(NSDictionary *)getDic postDic:(NSDictionary *)postDic complete:(void(^)(void))complete success:(void(^)(id response))success failure:(void(^)(NSError *error))failure {
    
    NSMutableDictionary *getParam = getDic.mutableCopy;
    [DZApiRequest requestWithConfig:^(JTURLRequest *request) {
        
        if (attacheType == DZAttacheImage || attacheType == DZAttacheVote) {
            if (attacheType == DZAttacheImage) {
                [getParam setValue:@"image" forKey:@"type"];
            }
            for (UIImage *image in attachArr) {
                NSData *data = [image limitImageSize];
                NSString *nowTime = [[NSDate date] stringFromDateFormat:@"yyyyMMddHHmmss"];
                NSString *fileName = [NSString stringWithFormat:@"%@.png", nowTime];
                [request addFormDataWithName:@"Filedata" fileName:fileName mimeType:@"image/png" fileData:data];
            }
        } else if (attacheType == DZAttacheAudio) {
            for (NSString *soundPath in attachArr) {
                NSData *audioData = [NSData dataWithContentsOfFile:soundPath];
                NSString *nowTime = [[NSDate date] stringFromDateFormat:@"yyyyMMddHHmmss"];
                NSString * fileName = [NSString stringWithFormat:@"%@.mp3", nowTime];
                [request addFormDataWithName:@"Filedata" fileName:fileName mimeType:@"audio/mp3" fileData:audioData];
            }
        }
        request.urlString = DZ_Url_UploadFile;
        request.getParam = getParam;
        request.parameters = postDic;
        request.methodType = JTMethodTypeUpload;
    } progress:^(NSProgress *progress) {
        if (100.f * progress.completedUnitCount/progress.totalUnitCount == 100) {
            //            complete?complete():nil;
        }
        //        DLog(@"onProgress: %.2f", 100.f * progress.completedUnitCount/progress.totalUnitCount);
    } success:^(id responseObject, JTLoadType type) {
        complete?complete():nil;
        if (attacheType == DZAttacheVote) {
            id resDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            success?success(resDic):nil;
        } else {
            NSString * str =[[NSMutableString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            if ([DataCheck isValidString:str]) {
                NSArray *responseArr = [str componentsSeparatedByString:@"|"];
                if (responseArr.count == 5) {
                    NSString *messageStatus = responseArr[1];
                    if ([messageStatus isEqualToString:@"0"]) {
                        NSString *aidStr = responseArr[2];
                        if (success) {
                            success(aidStr);
                        }
                    } else {
                        [MBProgressHUD showInfo:[self.uploadErrorDic objectForKey:messageStatus]];
                    }
                    return;
                }
            }
            [MBProgressHUD showInfo:@"上传失败"];
        }
        
    } failed:^(NSError *error) {
        complete?complete():nil;
        failure?failure(error):nil;
    }];
}

// 判断是否有发帖权限
- (void)DZ_CheckUserPostAuth:(NSString *)fid success:(void(^)(DZBaseAuthModel *authModel))success{
    
    NSString *fidStr = checkNull(fid);
    NSDictionary * dic =@{@"fid":fidStr};
    [DZApiRequest requestWithConfig:^(JTURLRequest *request) {
        request.urlString = DZ_Url_CheckPostAuth;
        request.parameters = dic;
        // ------------------ 这个地方，请求加个缓存 ------------
        request.loadType = JTRequestTypeCache;
        request.isCache = YES;
    } success:^(id responseObject, JTLoadType type) {
        DZBaseAuthModel *model = [DZBaseAuthModel modelWithJSON:[responseObject objectForKey:@"Variables"]];
        if (success) {
            success(model);
        }
    } failed:^(NSError *error) {
        if (success) {
            success(nil);
        }
    }];
}


// 帖子举报
-(void)DZ_ThreadReport:(NSString *)threadId reportMsg:(NSString *)msg fid:(NSString *)fid success:(void(^)(BOOL isSucc))success{
    
    if (!msg.length || !threadId.length) {
        return;
    }
    
    [DZApiRequest requestWithConfig:^(JTURLRequest *request) {
        NSDictionary * dic = @{@"formhash":[DZMobileCtrl sharedCtrl].User.formhash,
                               @"reportsubmit":@"true",
                               @"message":checkNull(msg),
                               @"rtype":@"post",
                               @"rid":checkNull(threadId),
                               @"fid":checkNull(fid),
                               @"inajax":@1,
        };
        request.urlString = DZ_Url_Report;
        request.parameters = dic;
        request.methodType = JTMethodTypePOST;
    } success:^(id responseObject, JTLoadType type) {
        DZBaseResModel *resModel = [DZBaseResModel modelWithJSON:responseObject];
        if (resModel.Message && resModel.Message.isSuccessed) {
            if (success) {
                success(YES);
            }
        }else{
            if (success) {
                success(NO);
            }
        }
    } failed:^(NSError *error) {
        if (success) {
            success(NO);
        }
    }];
}


// 查看投票详情
-(void)DZ_DownloadVoteOptionsDetail:(NSString *)tid pollid:(NSString *)pollid success:(void(^)(DZVoteResModel *voteModel))success{
    
    NSString *tidStr = checkNull(tid);
    NSString *pollidStr = checkNull(pollid);
    if (!tidStr.length || success) {
        return;
    }
    NSMutableDictionary *postDict = [NSMutableDictionary dictionaryWithDictionary:@{@"tid":tidStr}];
    if (pollidStr.length) {
        [postDict addEntriesFromDictionary:@{@"polloptionid":pollidStr}];
    }
    
    [DZApiRequest requestWithConfig:^(JTURLRequest *request) {
        request.urlString = DZ_Url_VoteOptionDetail;
        request.parameters = postDict;
    } success:^(id responseObject, JTLoadType type) {
        DZVoteResModel *voteVarModel = [DZVoteResModel modelWithJSON:responseObject];
        if (voteVarModel) {
            success(voteVarModel);
        }else{
            success(nil);
        }
    } failed:^(NSError *error) {
        success(nil);
    }];
    
}


//获取帖子详情
-(void)DZ_DownloadPostDetail:(NSString *)tid Page:(NSInteger)page success:(void(^)(DZPosResModel *varModel,NSDictionary *resDict,NSError *error))success{
    
    NSString *tidStr = checkNull(tid);
    if (!tidStr.length || !success) {
        return;
    }
    
    [DZApiRequest requestWithConfig:^(JTURLRequest *request) {
        NSDictionary *dic = @{@"tid":tidStr,
                              @"page":checkInteger(page)
        };
        request.urlString = DZ_Url_ThreadDetail;
        request.parameters = dic;
    } success:^(id responseObject, JTLoadType type) {
        
        DZPosResModel *postModel = [DZPosResModel modelWithJSON:responseObject];
        
        if (success) {
            success(postModel,responseObject,nil);
        }
        
    } failed:^(NSError *error) {
        if (success) {
            success(nil,nil,error);
        }
    }];
}


// 发布帖子
+ (void)DZ_PublistPostThread:(NSString *)fid postDict:(NSDictionary *)postDict completion:(void(^)(DZBaseResModel *resModel,NSString *tidStr,NSError *error))completion{
    
    if (!fid.length || !postDict.allValues.count || !completion) {
        return;
    }
    
    [DZApiRequest requestWithConfig:^(JTURLRequest *request) {
        request.methodType = JTMethodTypePOST;
        request.urlString = DZ_Url_PostCommonThread;
        request.parameters = postDict;
        request.getParam = @{@"fid":fid};
    } success:^(id responseObject, JTLoadType type) {
        NSString *tidStr = [[responseObject dictionaryForKey:@"Variables"] stringForKey:@"tid"];
        DZBaseResModel *resModel = [DZBaseResModel modelWithJSON:responseObject];
        completion(resModel,tidStr,nil);
    } failed:^(NSError *error) {
        completion(nil,nil,error);
    }];
    
}



/// 取消活动
+ (void)DZ_CancelPostedActivity:(NSString *)tid Thread:(ThreadModel *)threadModel completion:(void(^)(DZBaseResModel *resModel,NSError *error))completion{
    
    if (!tid.length || !threadModel || !completion) {
        return;
    }
    //取消活动
    [DZApiRequest requestWithConfig:^(JTURLRequest *request) {
        NSDictionary * dic = @{@"tid":tid,
                               @"fid":threadModel.fid,
                               @"pid":threadModel.pid,
        };
        NSDictionary *postDic = @{@"tid":tid,
                                  @"fid":threadModel.fid,
                                  @"pid":threadModel.pid,
                                  @"activitycancel":@"true",
                                  @"formhash":[DZMobileCtrl sharedCtrl].User.formhash
        };
        request.methodType = JTMethodTypePOST;
        request.urlString = DZ_Url_ActivityApplies;
        request.parameters = postDic;
        request.getParam = dic;
    } success:^(id responseObject, JTLoadType type) {
        DZBaseResModel *resModel = [DZBaseResModel modelWithJSON:responseObject];
        completion(resModel,nil);
    } failed:^(NSError *error) {
        completion(nil,error);
    }];
}




/// 发布帖子 回复（回帖）
+ (void)DZ_SendPostReply:(NSDictionary *)dict completion:(void(^)(DZBaseResModel *resModel,NSError *error))completion{
    
    if (!dict.allValues.count || !completion) {
        return;
    }
    
    [DZApiRequest requestWithConfig:^(JTURLRequest *request) {
        request.methodType = JTMethodTypePOST;
        request.urlString = DZ_Url_Sendreply;
        request.parameters = dict;
    } success:^(id responseObject, JTLoadType type) {
        DZBaseResModel *resModel = [DZBaseResModel modelWithJSON:responseObject];
        completion(resModel,nil);
    } failed:^(NSError *error) {
        completion(nil,error);
    }];
    
}


/// 参与投票
+(void)DZ_PubLishVoteWithData:(id)data fid:(NSString *)fid tid:(NSString *)tid completion:(void(^)(DZBaseResModel *resModel,NSError *error))completion{
    
    if (!data || !fid.length || !tid.length || !completion) {
        return;
    }
    NSString * strUrl = [data stringByReplacingOccurrencesOfString:@"{" withString:@""];
    NSString * str1 = [strUrl stringByReplacingOccurrencesOfString:@"}" withString:@""];
    NSArray *pollanswers = [str1 componentsSeparatedByString:@"|"];
    NSDictionary * postdic=@{@"formhash":[DZMobileCtrl sharedCtrl].User.formhash,
                             @"pollanswers":pollanswers};
    NSDictionary *getDic = @{@"fid":fid,
                             @"tid":tid};
    
    [DZApiRequest requestWithConfig:^(JTURLRequest *request) {
        request.methodType = JTMethodTypePOST;
        request.urlString = DZ_Url_Pollvote;
        request.parameters = postdic;
        request.getParam = getDic;
    } success:^(id responseObject, JTLoadType type) {
        DZBaseResModel *resModel = [DZBaseResModel modelWithJSON:responseObject];
        completion(resModel,nil);
    } failed:^(NSError *error) {
        completion(nil,error);
    }];
    
}


/// 获取引用的回复 （带有Html标签）
+ (void)DZ_ReferenceReply:(NSString *)dataStr tid:(NSString *)tid completion:(void(^)(DZBaseResModel *resModel,NSString * notice,NSError *error))completion{
    
    if (!dataStr.length || !tid.length || !completion) {
        return;
    }
    NSDictionary * dict =@{@"tid":tid,
                           @"repquote":dataStr};
    [DZApiRequest requestWithConfig:^(JTURLRequest *request) {
        
        request.urlString = DZ_Url_ReplyContent;
        request.parameters = dict;
    } success:^(id responseObject, JTLoadType type) {
        DZBaseResModel *resModel = [DZBaseResModel modelWithJSON:responseObject];
        NSString *notice = [[responseObject objectForKey:@"Variables"] objectForKey:@"noticetrimstr"];
        completion(resModel,notice,nil);
    } failed:^(NSError *error) {
        completion(nil,nil,error);
    }];
}


// 参与活动
+ (void)DZ_APPlyActivity:(NSDictionary *)paraDict getDict:(NSDictionary *)getDict completion:(void(^)(DZBaseResModel *resModel,NSError *error))completion{
    
    if (!getDict.allValues.count || !paraDict.allValues.count || !completion) {
        return;
    }
    
    [DZApiRequest requestWithConfig:^(JTURLRequest *request) {
        request.urlString = DZ_Url_ActivityApplies;
        request.methodType = JTMethodTypePOST;
        request.parameters = paraDict;
        request.getParam = getDict;
    } success:^(id responseObject, JTLoadType type) {
        DZBaseResModel *resModel = [DZBaseResModel modelWithJSON:responseObject];
        completion(resModel,nil);
    } failed:^(NSError *error) {
        completion(nil,error);
    }];
}


// 活动管理 （批准，删除等操作）
+ (void)DZ_ManageActivity:(NSString *)tid reason:(NSString *)reason operation:(NSString *)operation applyid:(NSString *)applyid completion:(void(^)(DZBaseResModel *resModel,NSError *error))completion{
    
    if (!tid.length || !reason.length || !operation.length || !applyid.length || !completion) {
        return;
    }
    
    NSDictionary *postDic = @{@"formhash":[DZMobileCtrl sharedCtrl].User.formhash,
                              @"handlekey":@"activity",
                              @"applyidarray[]":applyid,
                              @"reason":reason,
                              @"operation":operation};
    NSDictionary *getDic = @{@"tid":tid,
                             @"applylistsubmit":@"yes"};
    [DZApiRequest requestWithConfig:^(JTURLRequest *request) {
        request.urlString = DZ_Url_ManageActivity;
        request.parameters = postDic;
        request.getParam = getDic;
        request.methodType = JTMethodTypePOST;
    } success:^(id responseObject, JTLoadType type) {
        DZBaseResModel *resModel = [DZBaseResModel modelWithJSON:responseObject];
        completion(resModel,nil);
    } failed:^(NSError *error) {
        completion(nil,error);
    }];
}





#pragma mark   /********************* 对象属性初始化 *************************/

- (NSDictionary *)uploadErrorDic {
    if (!_uploadErrorDic) {
        _uploadErrorDic = @{@"-1":@"内部服务器错误",
                            @"0":@"上传成功",
                            @"1":@"不支持此类扩展名",
                            @"2":@"服务器限制无法上传那么大的附件",
                            @"3":@"用户组限制无法上传那么大的附件",
                            @"4":@"不支持此类扩展名",
                            @"5":@"文件类型限制无法上传那么大的附件",
                            @"6":@"今日您已无法上传更多的附件",
                            @"7":@"请选择图片文件",
                            @"8":@"附件文件无法保存",
                            @"9":@"没有合法的文件被上传",
                            @"10":@"非法操作",
                            @"11":@"今日您已无法上传那么大的附件"};
    }
    return _uploadErrorDic;
}


@end

