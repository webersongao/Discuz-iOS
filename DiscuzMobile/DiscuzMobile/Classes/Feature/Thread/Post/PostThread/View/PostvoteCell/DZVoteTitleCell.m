//
//  DZVoteTitleCell.m
//  DiscuzMobile
//
//  Created by HB on 16/11/30.
//  Copyright © 2016年 comsenz-service.com.  All rights reserved.
//

#import "DZVoteTitleCell.h"

@interface DZVoteTitleCell()

@property (nonatomic, strong) UIView *lineV;

@end

@implementation DZVoteTitleCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self p_setupViews];
    }
    return self;
}

- (void)p_setupViews {
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.titleTextField = [[UITextField alloc] initWithFrame:CGRectMake(15, 5, KScreenWidth - 20, 45)];
    self.titleTextField.placeholder = @" 标题(最多只能输入80个字符)";
    self.titleTextField.font = KFont(15);
    [self.contentView addSubview:self.titleTextField];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleTextField.frame = CGRectMake(10, 5, KScreenWidth, 45);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
