//
//  DZBaseTableViewCell.m
//  PandaReader
//
//  Created by 孙震 on 2019/5/13.
//  Copyright © 2019 ZHWenXue. All rights reserved.
//

#import "DZBaseTableViewCell.h"

@implementation DZBaseTableViewCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = KRandom_Color;
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self loadSetting];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)loadSetting {
    self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
    self.selectedBackgroundView.backgroundColor = KColor(@"#F7F7F8", 1);
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
