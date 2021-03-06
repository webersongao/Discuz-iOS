//
//  DZPublicPMCell.m
//  DiscuzMobile
//
//  Created by gensinimac1 on 15/10/15.
//  Copyright © 2015年 comsenz-service.com. All rights reserved.
//

#import "DZPublicPMCell.h"

@implementation DZPublicPMCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 49, 49)];
//    self.headImageView.backgroundColor = [UIColor redColor];
    self.headImageView.image = [UIImage imageNamed:@"消息"];
    [self addSubview:self.headImageView];
    
    CGRect frame = self.headImageView.frame;
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width+20, 10, 190, 15)];
    self.nameLabel.font = KFont(14);//13-14
    self.nameLabel.textColor = K_Color_Theme;
    [self addSubview:self.nameLabel];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(KScreenWidth-100, 10,90, 15)];
    self.timeLabel.font = KFont(10);//10
    self.timeLabel.textColor = mRGBColor(180, 180, 180);
    [self addSubview:self.timeLabel];
    
    self.contenLabel = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width+20, 25, KScreenWidth-(frame.size.width+20+10), 45)];
    self.contenLabel.font =  KFont(12);//12
    self.contenLabel.numberOfLines = 0;
    [self addSubview:self.contenLabel];
    
}

- (void)setdata:(NSDictionary*)dic {
    if ([DataCheck isValidString:[dic objectForKey:@"id"]]) {// 是否是系统消息
        // 是系统消息
        NSString * timeStr = [NSDate timeStringFromTimestamp:[dic objectForKey:@"dateline"] format:@"yyyy-MM-dd"];
        self.timeLabel.text = [timeStr transformationStr];
        DLog(@"%@",[dic objectForKey:@"dateline"]);
        DLog(@"%@",[dic objectForKey:@"message"]);
        self.contenLabel.text = [dic objectForKey:@"message"];
        self.nameLabel.text =@"系统消息";
    }
}

@end
