//
//  DZThreadListModel.m
//  DiscuzMobile
//
//  Created by HB on 17/1/18.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import "DZThreadListModel.h"
#import "DZAttachModel.h"

@implementation DZThreadListModel

+ (NSDictionary*)modelCustomPropertyMapper {
    return @{
        @"typeId" : @"typeid",
    };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"attachlist" : [DZAttachModel class],
             @"reply" : [DZThreadReplyModel class]
    };
}

#pragma mark - 重写settter方法 过滤标签

-(void)setViews:(NSString *)views{
    _views = [views onePointCountWithNumstring];
}

-(void)setReplies:(NSString *)replies{
    _replies = [replies onePointCountWithNumstring];
}

-(void)setMessage:(NSString *)message{
    _message = [message transformationStr];
}

-(void)setRecommend_add:(NSString *)recommend_add{
    _recommend_add = [recommend_add onePointCountWithNumstring];
}

-(void)setDateline:(NSString *)dateline{
    NSCharacterSet *notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    if ([_dateline rangeOfCharacterFromSet:notDigits].location == NSNotFound) { // 是数字
        _dateline = [NSDate timeStringFromTimestamp:dateline format:@"yyyy-MM-dd"];
    }else{
        _dateline = [dateline transformationStr];
    }
}

-(void)setSubject:(NSString *)subject{
    _subject = [subject transformationStr];
    _useSubject = _subject;
}

-(void)setAttachlist:(NSMutableArray<DZAttachModel *> *)attachlist{
    _attachlist = attachlist;
    self.imglist = [NSMutableArray array];
    for (DZAttachModel *attch in attachlist) {
        if ([attch.type isEqualToString:@"image"]) {
            [self.imglist addObject:attch.thumb];
        }
    }
}

-(void)setGrouptitle:(NSString *)grouptitle {
    if ([DataCheck isValidString:grouptitle]) {
        _grouptitle = [grouptitle flattenHTMLTrimWhiteSpace:YES];
    }else{
        _grouptitle = @"";
    }
}

-(void)setTypeName:(NSString *)typeName {
    if ([DataCheck isValidString:typeName]) {
        _typeName = [typeName flattenHTMLTrimWhiteSpace:YES];
    }else{
        _typeName = @"";
    }
}


// 特殊帖判断
- (BOOL)isSpecialThread {
    NSArray *specialArr = @[@"1",@"4",@"5"];
    if ([DataCheck isValidString:self.special]) {
        if ([specialArr containsObject:self.special]) {
            return YES;
        }
    }
    return NO;
}

// 置顶帖判断
- (BOOL)isTopThread {
    NSArray *topCheckArray = @[@"1",@"2",@"3"];
    if ([topCheckArray containsObject:self.displayorder]) {
        return YES;
    }
    return false;
}


// 是否是本版帖子
- (BOOL)isCurrentForum:(NSString *)fid {
   if ([@[@"3",@"2"] containsObject:self.displayorder] && ![self.fid isEqualToString:fid]) { // 非本版帖子
       return YES;
    }
    return NO;
}


@end
