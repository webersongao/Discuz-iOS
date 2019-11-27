//
//  ActiveContentCell.h
//  DiscuzMobile
//
//  Created by HB on 16/11/30.
//  Copyright © 2016年 comsenz-service.com.  All rights reserved.
//

#import "DZBaseTableViewCell.h"
#import "DZSelectTipView.h"

@interface ActiveContentCell : DZBaseTableViewCell

@property (nonatomic, strong) UITextField *placeTextField;
@property (nonatomic, strong) UITextField *cityTextField;
@property (nonatomic, strong) UITextField *peopleNumTextField;
@property (nonatomic, strong) UITextField *classTextField;
@property (nonatomic, strong) DZSelectTipView *sexSelectView;
@property (nonatomic, strong) UIButton * Dropdownbtn;
@property (nonatomic, strong) DZSelectTipView *classSelectView;

@property (nonatomic, strong) UIButton *nameBtn;
@property (nonatomic, strong) UIButton *phoneBtn;
@property (nonatomic, strong) UIButton *qqBtn;

@end
