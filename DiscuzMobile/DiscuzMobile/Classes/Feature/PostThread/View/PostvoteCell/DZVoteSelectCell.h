//
//  DZVoteSelectCell.h
//  DiscuzMobile
//
//  Created by HB on 16/11/30.
//  Copyright © 2016年 comsenz-service.com.  All rights reserved.
//

#import "DZBaseTableViewCell.h"
#import "QRadioButton.h"

@interface DZVoteSelectCell : DZBaseTableViewCell

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) QRadioButton *singleRadio;
@property (nonatomic, strong) QRadioButton *multiRadio;

@end
