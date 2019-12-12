//
//  DZThreadListCell.m
//  DiscuzMobile
//
//  Created by HB on 17/1/18.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import "DZThreadListCell.h"

@interface DZThreadListCell()

@property (nonatomic, strong) UIImageView *typeIcon;

@end

@implementation DZThreadListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addInit];
    }
    return  self;
}

- (void)addInit {
    [self.mainTitleLabel addSubview:self.typeIcon];
}


- (void)updateThreadCell:(DZThreadListModel *)listInfo{
    [super updateThreadCell:listInfo];
    
    if (![listInfo isSpecialThread]) {
        self.typeIcon.hidden = YES;
    } else {
        self.typeIcon.hidden = NO;
        self.typeIcon.frame = CGRectMake(0, 2, 16, 16);
        if ([listInfo.special isEqualToString:@"1"]) {
            self.typeIcon.image = [UIImage imageNamed:@"votesmall"];
        } else if ([listInfo.special isEqualToString:@"4"]) {
            self.typeIcon.image = [UIImage imageNamed:@"activitysmall"];
        } else if ([listInfo.special isEqualToString:@"5"]) {
            self.typeIcon.image = [UIImage imageNamed:@"debatesmall"];
        }
    }
}

- (UIImageView *)typeIcon {
    if (_typeIcon == nil) {
        _typeIcon = [[UIImageView alloc] init];
        _typeIcon.hidden = YES;
    }
    return _typeIcon;
}

@end
