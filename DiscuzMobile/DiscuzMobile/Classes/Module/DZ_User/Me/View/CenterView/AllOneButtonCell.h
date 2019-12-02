//
//  AllOneButtonCell.h
//  DiscuzMobile
//
//  Created by HB on 16/12/1.
//  Copyright © 2016年 comsenz-service.com.  All rights reserved.
//

#import "DZBaseTableViewCell.h"

typedef void(^BtnActionBlock)(UIButton *sender);

@interface AllOneButtonCell : DZBaseTableViewCell

@property (nonatomic, strong) UIButton *ActionBtn;

@property (nonatomic, copy) BtnActionBlock actionBlock;

@end
