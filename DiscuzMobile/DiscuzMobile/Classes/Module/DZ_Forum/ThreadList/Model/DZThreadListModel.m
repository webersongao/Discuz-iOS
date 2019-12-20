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
    _mainTitle = [self AttributedSubject:subject secial:self.special];
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

-(void)setReply:(NSArray<DZThreadReplyModel *> *)reply{
    _reply = reply;
    DZThreadReplyModel *last = reply.lastObject;
    _lastReplyString = last.message;
    _lastReply = [self AttributedReply:last.message];
}

-(void)setDigest:(NSString *)digest{
    _digest = digest;
    
    if ([digest isEqualToString:@"1"] || [digest isEqualToString:@"2"] || [digest isEqualToString:@"3"]) {
        self.tagImage = [UIImage imageNamed:@"精华"];
    } else if ([digest isEqualToString:@"0"]) {
        self.tagImage = nil;
    }else{
        self.tagImage = [UIImage imageNamed:@"热门"];
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


#pragma mark   /********************* 数据格式化 *************************/

-(NSAttributedString *)AttributedReply:(NSString *)String{
    return [NSString attributeWithLineSpaceing:5 text:String font:KFont(14.f)];
}

-(NSAttributedString *)AttributedSubject:(NSString *)String secial:(NSString *)special{
    NSString *typeIcon = nil;
    if ([special isEqualToString:@"1"]) {
        typeIcon = @"votesmall";
    } else if ([special isEqualToString:@"4"]) {
        typeIcon = @"activitysmall";
    } else if ([special isEqualToString:@"5"]) {
        typeIcon = @"debatesmall";
    }
    
    return [NSString attributedWithLeftimage:typeIcon RightTittle:String textColor:[UIColor redColor] FontSize:16];
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
    
    CGFloat cellWidth = KScreenWidth;
    CGFloat textWidth = cellWidth - kMargin20;
    CGFloat buttonWidth = textWidth/3.f;
    
    self.iconFrame = CGRectMake(kMargin10, kMargin10, 30, 30);
    CGFloat attachHeight = cellModel.imglist.count ? KWidthScale(90) : 0;
    CGFloat nameWidth = [NSString cacaulteStringWidth:cellModel.author fontSize:16];
    CGFloat timeWidth = [NSString cacaulteStringWidth:cellModel.dateline fontSize:12];
    CGFloat gradeWidth = [NSString cacaulteStringWidth:cellModel.gradenName fontSize:12];
    CGFloat subtitleHeight = [NSString cacaulteStringHeight:cellModel.lastReplyString fontSize:14 width:textWidth lineSpacing:5];
    
    self.nameFrame = CGRectMake(CGRectGetMaxX(self.iconFrame) + kMargin10, kMargin10, nameWidth, 30);
    self.gradeFrame = CGRectMake(CGRectGetMaxX(self.nameFrame)+ kMargin10, kMargin10, gradeWidth, cellModel.gradenName.length ? 30 : 0);
    self.tagFrame = CGRectMake(cellWidth-kMargin10-34, (60-17)/2.f, 34, 17);
    
    self.lineOneFrame = CGRectMake(kMargin10,CGRectGetMaxY(self.iconFrame)+kMargin10, textWidth, 0.5);
    self.titleFrame = CGRectMake(kMargin10, CGRectGetMaxY(self.lineOneFrame)+kMargin10, textWidth-kMargin10-timeWidth, 17.f);
    self.subtitleFrame = CGRectMake(kMargin10, CGRectGetMaxY(self.titleFrame), textWidth, subtitleHeight);
    self.timeFrame = CGRectMake(CGRectGetMaxX(self.titleFrame)+kMargin10, CGRectGetMinY(self.titleFrame), timeWidth, 13.f);
    
    self.attachFrame = CGRectMake(kMargin10, CGRectGetMaxY(self.subtitleFrame), textWidth, attachHeight);
    self.lineTwoFrame = CGRectMake(kMargin10, CGRectGetMaxY(self.attachFrame)+kMargin10, textWidth, 0.5);
    self.viewFrame = CGRectMake(kMargin10, CGRectGetMaxY(self.lineTwoFrame), buttonWidth, 40);
    self.replyFrame = CGRectMake(CGRectGetMaxX(self.viewFrame), CGRectGetMaxY(self.lineTwoFrame), buttonWidth, 40);
    self.zanFrame = CGRectMake(CGRectGetMaxX(self.replyFrame), CGRectGetMaxY(self.lineTwoFrame), buttonWidth, 40);
    self.lineThreeeFrame = CGRectMake(kMargin10, CGRectGetMaxY(self.zanFrame), textWidth, 0.5);
    
    self.cellHeight = CGRectGetMaxY(self.zanFrame)+kMargin10;
    
}




@end







