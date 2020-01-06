//
//  ActivityApplyDetailCell.m
//  DiscuzMobile
//
//  Created by HB on 2017/7/28.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import "ActivityApplyDetailCell.h"

@implementation ActivityApplyDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self commitInit];
    }
    return self;
}

- (void)commitInit {
    self.tipLab = [[UILabel alloc] init];
    self.tipLab.font = KFont(12);
    self.tipLab.textColor = K_Color_LightText;
    [self.contentView addSubview:self.tipLab];
    
    self.infoLab = [[UILabel alloc] init];
    self.infoLab.numberOfLines = 0;
    self.infoLab.font = KFont(14);
    [self.contentView addSubview:self.infoLab];
    
    self.tipLab.frame = CGRectMake(15, 0, 69, CGRectGetHeight(self.contentView.frame));
    self.infoLab.frame = CGRectMake(CGRectGetMaxX(self.tipLab.frame), 0, CGRectGetWidth(self.contentView.frame) - 69 - 30, CGRectGetHeight(self.tipLab.frame));
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.tipLab.frame = CGRectMake(15, 0, 69, CGRectGetHeight(self.contentView.frame));
    
    CGSize maxSize = CGSizeMake(CGRectGetWidth(self.contentView.frame) - 69 - 30, MAXFLOAT);
    CGSize textSize = [self.infoLab.text sizeWithFont:KFont(14) maxSize:maxSize];
    CGFloat height = 38;
    if (textSize.height > 38) {
        height = textSize.height;
    }
    
    self.infoLab.frame = CGRectMake(CGRectGetMaxX(self.tipLab.frame), 0, textSize.width, height);
}

- (CGFloat)cellHeight {
    
    if ([DataCheck isValidString:self.infoLab.text]) {
        DLog(@"%@",self.infoLab.text);
        CGSize maxSize = CGSizeMake(KScreenWidth - 60 - 20 - 69 - 30, MAXFLOAT);
        CGSize textSize = [self.infoLab.text sizeWithFont:KFont(14) maxSize:maxSize];
        CGFloat height = 38;
        if (textSize.height > 38) {
            height = textSize.height;
        }
        return height + 5;
    } else {
        return 38;
    }
}


@end
