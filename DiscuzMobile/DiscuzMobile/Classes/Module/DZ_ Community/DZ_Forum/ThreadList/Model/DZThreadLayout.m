//
//  DZThreadLayout.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/24.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZThreadLayout.h"
#import "DZThreadListModel.h"

@implementation DZTHHeadLayout


@end

@implementation DZTHBottomLayout


@end

@implementation DZThreadLayout

- (instancetype)initWithModel:(DZThreadListModel *)Model isList:(BOOL)isList isTop:(BOOL)isTop
{
    self = [super init];
    if (self) {
        self.isTop = isTop;
        if (isList) {
            [self caculateListCell:Model isTop:isTop];
        }else{
            [self caculateSquareCell:Model isTop:isTop];
        }
    }
    return self;
}

-(void)caculateListCell:(DZThreadListModel *)cellModel isTop:(BOOL)isTop{
    
    CGFloat cellWidth = KScreenWidth;
    CGFloat textWidth = cellWidth - kMargin20;
    CGFloat buttonWidth = textWidth/3.f ? : 90;
    
    self.headLayout = [[DZTHHeadLayout alloc] init];
    self.bottomLayout = [[DZTHBottomLayout alloc] init];
    
    CGFloat attachHeight = cellModel.imglist.count ? KWidthScale(90) : 0;
    CGFloat nameWidth = [NSString cacaulteStringWidth:cellModel.author fontSize:16];
    CGFloat timeWidth = [NSString cacaulteStringWidth:cellModel.dateline fontSize:12];
    CGFloat gradeWidth = [NSString cacaulteStringWidth:cellModel.gradeName fontSize:12];
    CGFloat subtitleHeight = [NSString cacaulteStringHeight:cellModel.lastReplyString fontSize:14 width:textWidth lineSpacing:5];
    
    if (!isTop) {
        self.headFrame = CGRectMake(0, 0, cellWidth, kMargin40);
        
        self.headLayout.iconFrame = CGRectMake(kMargin10, 5.f, 30, 30);
        self.headLayout.nameFrame = CGRectMake(CGRectGetMaxX(self.headLayout.iconFrame) + kMargin10, 5.f, nameWidth, 30);
        self.headLayout.gradeFrame = CGRectMake(CGRectGetMaxX(self.headLayout.nameFrame)+ kMargin10, 5.f, gradeWidth, cellModel.gradeName.length ? 30 : 0);
        self.headLayout.tagFrame = CGRectMake(cellWidth-kMargin10-34, (kMargin40-17)/2.f, 34, 17);
        CGFloat timeLabelLeft = cellModel.tagImage ? CGRectGetMinX(self.headLayout.tagFrame) : cellWidth;
        self.headLayout.timeFrame = CGRectMake(timeLabelLeft - kMargin10 - timeWidth, 5.f, timeWidth, 30);
    }
    
    self.titleFrame = CGRectMake(kMargin10, isTop ? kMargin10 : (CGRectGetMaxY(self.headFrame)+kMargin10), textWidth, 17.f);
    
    if (!isTop) {
        self.contentFrame = CGRectMake(kMargin10, CGRectGetMaxY(self.titleFrame)+5.f, textWidth, subtitleHeight);
        self.attachFrame = CGRectMake(kMargin10, CGRectGetMaxY(self.contentFrame)+5.f, textWidth, attachHeight);
        
        self.bottomFrame = CGRectMake(0, CGRectGetMaxY(self.attachFrame)+kMargin10, cellWidth, kMargin30+5.f);
        
        self.bottomLayout.viewFrame = CGRectMake(kMargin10, 0, buttonWidth, kMargin30);
        self.bottomLayout.replyFrame = CGRectMake(CGRectGetMaxX(self.bottomLayout.viewFrame), 0, buttonWidth, kMargin30);
        self.bottomLayout.zanFrame = CGRectMake(CGRectGetMaxX(self.bottomLayout.replyFrame), 0, buttonWidth, kMargin30);
        self.bottomLayout.lineFrame = CGRectMake(0, kMargin30, cellWidth, 5.f);
    }
    
    self.cellHeight = CGRectGetMaxY(isTop ? self.titleFrame : self.bottomFrame) + kMargin10;
    
}

-(void)caculateSquareCell:(DZThreadListModel *)cellModel isTop:(BOOL)isTop{
    
    
    
}





@end
