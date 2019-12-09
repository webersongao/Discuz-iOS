//
//  DZThreadListModel+Display.m
//  DiscuzMobile
//
//  Created by ZhangJitao on 2019/7/31.
//  Copyright © 2019 comsenz-service.com.  All rights reserved.
//

#import "DZThreadListModel+Display.h"
#import "DZThreadVarModel.h"

@implementation DZThreadListModel (Display)

/**
 根据帖子类型设置描述
 
 @param page 页数
 @param groupDic 所在群组
 @param typeDic 帖子类型 投票、活动等
 @return 帖子model
 */
-(DZThreadListModel *)dealModelWithPage:(NSInteger)page andGroup:(NSDictionary *)groupDic andType:(NSDictionary *)typeDic {
    
    self.grouptitle = [groupDic stringForKey:self.authorid];
    
    self.typeName = [typeDic stringForKey:self.typeId];
    self.useSubject = [self dealSpecialTypeThread:page];
    
    return self;
}


- (DZThreadListModel *)dealSpecialThread{
    self.useSubject = [self dealSpecialTypeThread:0];
    return self;
}


- (NSString *)dealSpecialTypeThread:(NSInteger)page {
    NSString *useSubjectStr = self.useSubject;
    if ([self isTopThread] && page == 1 && self.typeName.length) {
        useSubjectStr = [NSString stringWithFormat:@"%@,%@",self.typeName,self.subject];
    } else {
        NSString *spaceCharater = @"    ";
        if ([self isSpecialThread]) {
            if (self.typeName.length) {
                useSubjectStr = [NSString stringWithFormat:@"%@[%@]%@",spaceCharater,self.typeName,self.subject];
            } else {
                useSubjectStr = [NSString stringWithFormat:@"%@%@",spaceCharater,self.subject];
            }
        } else {
            if (self.typeName.length) {
                useSubjectStr = [NSString stringWithFormat:@"[%@]%@",self.typeName,self.subject];
            }
        }
    }
    
    return useSubjectStr;
}


@end












