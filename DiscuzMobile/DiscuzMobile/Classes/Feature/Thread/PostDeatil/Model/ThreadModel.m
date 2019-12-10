//
//  ThreadModel.m
//  DiscuzMobile
//
//  Created by HB on 17/3/7.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import "ThreadModel.h"
#import "DZThreadListModel.h"
#import "DZLoginModule.h"


@implementation ThreadModel

- (instancetype)updateModelWithRes:(DZPosResModel *)response
{
    [self updateVarPost:response];
    return self;
}

// MARK: - 通过这个set方法获取所有的model参数
-(void)updateVarPost:(DZPosResModel *)resModel{
    _VarPost = resModel.Variables;
    
    _favorited = @"0";
    _recommend = @"0";
    _favorited = _VarPost.thread.favorited;
    _recommend = _VarPost.thread.recommend;
    
    _specialString = _VarPost.thread.special;
    _fid = _VarPost.thread.fid;
    _replies = _VarPost.thread.replies;
    _subject = _VarPost.thread.subject;
    _author = _VarPost.thread.author;
    if (self.currentPage == 1 && _VarPost.postlist.count) {
        DZPostListItem *item = _VarPost.postlist.firstObject;
        _dateline = item.dateline;
        _pid = item.pid;
    }
    _shareUrl = [NSString stringWithFormat:@"%@forum.php?mod=viewthread&tid=%@",DZ_BASEURL,self.tid];
    
    NSDictionary *jsonDic = [self manageJsonContentWitnAttchment:resModel];
    _jsonData = [NSJSONSerialization dataWithJSONObject:jsonDic options:NSJSONWritingPrettyPrinted error:nil];
    
    _ppp = _VarPost.ppp;
    _isActivity = [self judeActivity:_VarPost];
    
    _allowpost = _VarPost.allowperm.allowpost;
    _allowreply = _VarPost.allowperm.allowreply;
    _uploadhash = _VarPost.allowperm.uploadhash;
    _baseUrl = [self getBaseURL:_VarPost];
}

#pragma mark - 获取本地页面url
- (NSURL *)getBaseURL:(DZPostVarModel *)dataDic {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"thread_temp_common" ofType:@"html"];
    if ([DataCheck isValidString:self.specialString]) {
        if ([self.specialString isEqualToString:@"1"]) { // 投票贴
            if ([dataDic.special_poll.allowvote isEqualToString:@"1"] && [dataDic.thread.closed isEqualToString:@"0"]) {
                path = [[NSBundle mainBundle] pathForResource:@"thread_temp_poll" ofType:@"html"];
            } else {
                path = [[NSBundle mainBundle] pathForResource:@"thread_temp_poll_result" ofType:@"html"];
            }
        } else if ([dataDic.thread.special isEqualToString:@"4"]) {
            path = [[NSBundle mainBundle] pathForResource:@"thread_temp_activity" ofType:@"html"];
        }
        //        else if ([dataDic.thread.special isEqualToString:@"5"]) { // 辩论帖
        //            path = [[NSBundle mainBundle] pathForResource:@"thread_temp_debate" ofType:@"html"];
        //        }
    }
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    return baseURL;
    
}

- (BOOL)judeActivity:(DZPostVarModel *)dataDic {
    // applied = 1 活动为存在;
    // 已参加或者 审批   button = cancel;  button = join;  有button Key 说明 能参加或者取消
    // closed = 0;   过期的时候为 1
    // "is_ex" = 0; 过期的时候为 1
    // applynumber 参加了几个
    //        NSString * strapplied= dataDic.special_activity.applied;
    NSString * strbutton = dataDic.special_activity.button;
    NSString * strclosed = dataDic.special_activity.closed;
    //    if ([strapplied isEqualToString:@"0"]&&[DataCheck isValidString:strapplied]&&[strbutton isEqualToString:@"join"]&&[DataCheck isValidString:strbutton]&&[strclosed isEqualToString:@"0"]&&[DataCheck isValidString:strclosed]) {
    //        return YES;
    //    }
    if ([DataCheck isValidString:strbutton] &&
        [DataCheck isValidString:strclosed]) {
        if ([strbutton isEqualToString:@"join"] &&
            [strclosed isEqualToString:@"0"]) {
            return YES;
        }
    }
    return NO;
}

- (NSDictionary *)manageJsonContentWitnAttchment:(DZPosResModel *)varPost {
    
    NSDictionary *oriDict = [varPost modelToJSONObject];
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionaryWithDictionary:oriDict];
    if (![DataCheck isValidDict:dataDic] || ![DataCheck isValidDict:oriDict]) {
        return nil;
    }
    
    [self dealWithattachment:dataDic];
    
    // 投票帖数据 - start
    NSMutableDictionary *special_poll = [[dataDic dictionaryForKey:@"Variables"] objectForKey:@"special_poll"];
    if ([DataCheck isValidDict:special_poll]) {
        NSMutableDictionary *polloptions  = [special_poll objectForKey:@"polloptions"];
        [polloptions enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            NSMutableDictionary *imginfo = [obj objectForKey:@"imginfo"];
            if ([DataCheck isValidDict:imginfo]) {
                NSString *small = [[imginfo objectForKey:@"small"] makeDomain];
                NSString *big = [[imginfo objectForKey:@"big"] makeDomain];
                [imginfo setValue:small forKey:@"small"];
                [imginfo setValue:big forKey:@"big"];
            }
        }];
    }
    // 投票帖数据 - end
    
    // 活动帖数据 - start
    NSMutableDictionary * special_activity = [[dataDic dictionaryForKey:@"Variables"] objectForKey:@"special_activity"];
    if ([DataCheck isValidDict:special_activity]) { // 取活动封面图
        NSString * thumburl = [special_activity stringForKey:@"thumb"];
        NSString * activityurl = [special_activity stringForKey:@"attachurl"];
        if (thumburl.length) {
            [special_activity setValue:[thumburl makeDomain] forKey:@"thumb"];
        }
        if (activityurl.length) {
            [special_activity setValue:[activityurl makeDomain] forKey:@"attachurl"];
        }
    }
    // 活动帖数据 - end
    
    return dataDic.mutableCopy;
}

- (void)dealWithattachment:(NSDictionary *)dataDic {
    
    NSMutableArray * list = [[dataDic dictionaryForKey:@"Variables"] objectForKey:@"postlist"];
    for (int i = 0; i<list.count; i++) {
        NSDictionary * item = [list objectAtIndex:i];
        
        NSMutableDictionary *attachmentsDic = [item objectForKey:@"attachments"];
        if ([DataCheck isValidDict:attachmentsDic]) {
            
            NSMutableArray *attachmentArr = [NSMutableArray array];
            NSMutableArray *mp3Arr = [NSMutableArray array];
            
            NSArray *sortArray = [attachmentsDic sortedValueByKeyInDesc:NO];
            
            for (NSDictionary *dic in sortArray) {
                NSMutableDictionary * attItem = dic.mutableCopy;
                NSString *ext = [dic objectForKey:@"ext"];
                NSString *attachurl = [[NSString stringWithFormat:@"%@%@",dic[@"url"],dic[@"attachment"]] makeDomain];
                [attItem setObject:attachurl forKey:@"attachurl"];
                if (![ext isEqualToString:@"mp3"]) {
                    if (![DataCheck isValidString:self.shareImageUrl]) {
                        _shareImageUrl = attachurl;
                    }
                    [attachmentArr addObject:attItem];
                    
                } else {
                    [mp3Arr addObject:attItem];
                }
            }
            
            [item setValue:attachmentArr forKey:@"attachlist"];
            [item setValue:mp3Arr forKey:@"audiolist"];
        }
    }
    
    //     DZPostThreadModel *listModel = [[DZPostThreadModel alloc] init];
    //     [DZPostThreadModel modelWithJSON:[[dataDic dictionaryForKey:@"Variables"] objectForKey:@"thread"]];
    //    if (self.currentPage == 1) {
    //        BACK(^{
    //            if ([DZLoginModule isLogged] && [DataCheck isValidString:listModel.tid]) {
    //                [[DZDatabaseHandle Helper] footThread:listModel];
    //            }
    //        });
    //    }
}

@end
