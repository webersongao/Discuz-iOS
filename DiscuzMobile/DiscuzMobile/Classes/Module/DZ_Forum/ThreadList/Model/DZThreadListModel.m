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


-(void)updateThreadModelLayout{
    self.layout = [[DZThreadLayout alloc] initWithModel:self];
}



@end

#pragma mark   /********************* DZThreadLayout 布局参数 *************************/


@implementation DZThreadLayout

- (instancetype)initWithModel:(DZThreadListModel *)Model
{
    self = [super init];
    if (self) {
        [self caculateCell:Model];
    }
    return self;
}

-(void)caculateCell:(DZThreadListModel *)cellModel{
    
//    self.threadHeight = KWidthScale(100);
//    self.attachHeight = cellModel.imglist.count ? KWidthScale(90) : 0;
    
}




@end







