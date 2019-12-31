//
//  DZPMListCell.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/31.
//  Copyright © 2019年 comsenz-service.com.  All rights reserved.
//

#import "DZPMListCell.h"
#import "DZHorizontalButton.h"

@implementation DZPMListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self dz_setupView];
    }
    return self;
}

- (void)dz_setupView {
    self.iconV = [[UIImageView alloc] init];
    self.iconV.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.iconV];
    
    self.titleLab = [[UILabel alloc] init];
    //    self.detailLab.backgroundColor= [UIColor redColor];
    self.titleLab.textAlignment = NSTextAlignmentLeft;
    self.titleLab.textColor = K_Color_MainTitle;
    self.titleLab.font = [DZFontSize HomecellNameFontSize16];
    [self.contentView addSubview:self.titleLab];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.iconV.frame = CGRectMake(kMargin15, (self.height - 18)/2.f, 18, 18);
    self.titleLab.frame = CGRectMake(CGRectGetMaxX(self.iconV.frame) + 8, (self.height - 24)/2.f, self.width - 65, 24);
}


@end
