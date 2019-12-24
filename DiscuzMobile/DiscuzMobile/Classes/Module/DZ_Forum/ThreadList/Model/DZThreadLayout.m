//
//  DZThreadLayout.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/24.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZThreadLayout.h"
#import "DZThreadListModel.h"

@implementation DZThreadLayout

- (instancetype)initWithModel:(DZThreadListModel *)Model isList:(BOOL)isList
{
    self = [super init];
    if (self) {
        if (isList) {
            [self caculateListCell:Model];
        }else{
            [self caculateSquareCell:Model];
        }
    }
    return self;
}

-(void)caculateListCell:(DZThreadListModel *)cellModel{
    
    CGFloat cellWidth = KScreenWidth;
    CGFloat textWidth = cellWidth - kMargin20;
    CGFloat buttonWidth = textWidth/3.f;
    
    self.iconFrame = CGRectMake(kMargin10, kMargin10, 30, 30);
    CGFloat attachHeight = cellModel.imglist.count ? KWidthScale(90) : 0;
    CGFloat nameWidth = [NSString cacaulteStringWidth:cellModel.author fontSize:16];
    CGFloat timeWidth = [NSString cacaulteStringWidth:cellModel.dateline fontSize:12];
    CGFloat gradeWidth = [NSString cacaulteStringWidth:cellModel.gradeName fontSize:12];
    CGFloat subtitleHeight = [NSString cacaulteStringHeight:cellModel.lastReplyString fontSize:14 width:textWidth lineSpacing:5];
    
    self.nameFrame = CGRectMake(CGRectGetMaxX(self.iconFrame) + kMargin10, kMargin10, nameWidth, 30);
    self.gradeFrame = CGRectMake(CGRectGetMaxX(self.nameFrame)+ kMargin10, kMargin10, gradeWidth, cellModel.gradeName.length ? 30 : 0);
    self.tagFrame = CGRectMake(cellWidth-kMargin10-34, (60-17)/2.f, 34, 17);
    
    self.lineOneFrame = CGRectMake(kMargin10,CGRectGetMaxY(self.iconFrame)+kMargin10, textWidth, 0.5);
    self.titleFrame = CGRectMake(kMargin10, CGRectGetMaxY(self.lineOneFrame)+kMargin10, textWidth-kMargin10-timeWidth, 17.f);
    self.subtitleFrame = CGRectMake(kMargin10, CGRectGetMaxY(self.titleFrame)+5.f, textWidth, subtitleHeight);
    self.timeFrame = CGRectMake(CGRectGetMaxX(self.titleFrame)+kMargin10, CGRectGetMinY(self.titleFrame), timeWidth, 13.f);
    
    self.attachFrame = CGRectMake(kMargin10, CGRectGetMaxY(self.subtitleFrame), textWidth, attachHeight);
    self.lineTwoFrame = CGRectMake(kMargin10, CGRectGetMaxY(self.attachFrame)+kMargin10, textWidth, 0.5);
    self.viewFrame = CGRectMake(kMargin10, CGRectGetMaxY(self.lineTwoFrame), buttonWidth, 40);
    self.replyFrame = CGRectMake(CGRectGetMaxX(self.viewFrame), CGRectGetMaxY(self.lineTwoFrame), buttonWidth, 40);
    self.zanFrame = CGRectMake(CGRectGetMaxX(self.replyFrame), CGRectGetMaxY(self.lineTwoFrame), buttonWidth, 40);
    self.lineThreeeFrame = CGRectMake(kMargin10, CGRectGetMaxY(self.zanFrame), textWidth, 0.5);
    
    self.cellHeight = CGRectGetMaxY(self.zanFrame)+kMargin10;
    
}

-(void)caculateSquareCell:(DZThreadListModel *)cellModel{
    
    
    
}





@end
