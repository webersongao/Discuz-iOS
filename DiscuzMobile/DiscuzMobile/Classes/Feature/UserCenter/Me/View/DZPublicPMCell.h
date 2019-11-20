//
//  DZPublicPMCell.h
//  DiscuzMobile
//
//  Created by gensinimac1 on 15/10/15.
//  Copyright © 2015年 comsenz-service.com. All rights reserved.
//

#import "DZBaseTableViewCell.h"

@interface DZPublicPMCell : DZBaseTableViewCell

@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * contenLabel;
@property (nonatomic, strong) UILabel * timeLabel;
-(void)setdata:(NSDictionary*)dic;
@end
