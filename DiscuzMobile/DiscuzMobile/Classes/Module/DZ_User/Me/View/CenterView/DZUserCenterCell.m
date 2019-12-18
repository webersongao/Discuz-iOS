//
//  DZUserCenterCell.m
//  DiscuzMobile
//
//  Created by HB on 17/1/19.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import "DZUserCenterCell.h"
#import "DZHorizontalButton.h"

@implementation DZUserCenterCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self p_setupView];
    }
    return self;
}

- (void)p_setupView {
    self.nameV = [[DZHorizontalButton alloc] init];
    [self.contentView addSubview:self.nameV];
    
    self.detailLab = [[UILabel alloc] init];
//    self.detailLab.backgroundColor= [UIColor redColor];
    self.detailLab.textAlignment = NSTextAlignmentRight;
    self.detailLab.font = [DZFontSize HomecellTimeFontSize14];
    self.detailLab.textColor = K_Color_LightText;
    [self.contentView addSubview:self.detailLab];
}

- (void)updateCenterCell:(TextIconModel *)model access:(BOOL)isIndicator{
    if (model != nil) {
        self.nameV.textLabel.text = model.text;
        self.nameV.iconV.image = [UIImage imageNamed:model.iconName];
        self.detailLab.text = model.detail;
    }
    
    self.accessoryType = isIndicator ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.nameV.frame = CGRectMake(kMargin15, kMargin10, 200, CGRectGetHeight(self.frame) - kMargin20);
    self.detailLab.frame = CGRectMake(KScreenWidth - 120 - kMargin15, CGRectGetMinY(self.nameV.frame), 120, CGRectGetHeight(self.nameV.frame));
}

@end
