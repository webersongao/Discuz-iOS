//
//  OtherUserThearCell.m
//  DiscuzMobile
//
//  Created by gensinimac1 on 15/8/24.
//  Copyright (c) 2015年 comsenz-service.com. All rights reserved.
//

#import "OtherUserThearCell.h"

@implementation OtherUserThearCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, KScreenWidth-20, 50)];
    self.titleLabel.font = KFont(14);//14
    self.titleLabel.numberOfLines = 0;
    [self addSubview:self.titleLabel];
    
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.titleLabel.frame.size.height+10, 80, 15)];
    self.nameLabel.textColor = K_Color_Theme;
    self.nameLabel.font = KFont(12);
    [self addSubview:self.nameLabel];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, self.titleLabel.frame.size.height+10, 120, 15)];
    self.timeLabel.textColor = mRGBColor(180, 180, 180);
    self.timeLabel.font = KFont(12);
    [self addSubview:self.timeLabel];
}

-(void)setData:(NSDictionary*)dic{
    self.titleLabel.text = [dic stringForKey:@"subject"];
    self.nameLabel.text = [dic stringForKey:@"author"];
    self.timeLabel.text =[dic stringForKey:@"dateline"];
    
}

@end
