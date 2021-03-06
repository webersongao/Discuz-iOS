//
//  ActiveUserFieldCell.m
//  DiscuzMobile
//
//  Created by HB on 2017/7/27.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import "ActiveUserFieldCell.h"
#import "DZSelectTypeButton.h"

@interface ActiveUserFieldCell()

@property (nonatomic, strong) UIView *selectView;

@end

@implementation ActiveUserFieldCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self commitInit];
    }
    return self;
}

- (void)commitInit {
    
    self.titleLab = [[UILabel alloc] init];
    self.titleLab.font = KFont(14);
    self.titleLab.textAlignment = NSTextAlignmentLeft;
    self.titleLab.textColor = K_Color_MainTitle;
    self.titleLab.text = @"用户报名填写项";
    [self.contentView addSubview:self.titleLab];
    
    self.selectView = [[UIView alloc] init];
    self.selectView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.selectView];
}

- (void)setActivityfield:(NSDictionary *)activityfield {
    
    _activityfield = activityfield;
    
    if ([DataCheck isValidDict:activityfield]) {
        
        self.titleLab.frame = CGRectMake(15, 18, KScreenWidth - 30, 20);
        CGFloat selectHeight = 0;
        
        if (activityfield.allKeys.count > 0) {
            
            CGFloat x_space = 15;
            CGFloat y_space = 15;
            CGFloat space = 15;
            CGFloat addWidth = 30;
            CGFloat btn_h = 30;
            
            if (KScreenWidth == 320) {
                space = 10;
                addWidth = 25;
            }
            
            selectHeight = btn_h + y_space * 2;
            
            for (UIView *button in self.selectView.subviews) {
                [button removeFromSuperview];
            }
            
            self.selectView.frame = CGRectMake(0, CGRectGetMaxY(self.titleLab.frame), KScreenWidth, selectHeight);
            
            
            __block CGFloat maxX = 0;
            __block NSInteger index = 0;
            __block NSInteger row = 0;
            __block NSInteger roi_row = 0;
            [activityfield enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                DZSelectTypeButton *button = [DZSelectTypeButton buttonWithType:UIButtonTypeCustom];
                [button setTitle:obj forState:UIControlStateNormal];
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                button.titleLabel.font = KFont(14);
                button.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
                CGSize textSize = [obj sizeWithFont:KFont(14) maxSize:CGSizeMake(KScreenWidth / 2, MAXFLOAT)];
                CGFloat b_width = textSize.width + addWidth;
                
                // ************
                
                if (maxX + b_width + space >= CGRectGetWidth(self.selectView.frame)) {
                    maxX = 0;
                    if (roi_row == row) {
                        row ++;
                    }
                }
                
                roi_row = row;
                
                button.frame = CGRectMake(maxX + x_space, y_space + (btn_h + y_space) * row, b_width, btn_h);
                maxX = CGRectGetMaxX(button.frame);
                // ************
                
                button.layer.cornerRadius  = 4.0;
                button.layer.borderWidth = 1.0;
                button.tag = 10001;
                button.layer.borderColor = K_Color_Theme.CGColor;
                
                button.tag = 100 + index;
                button.isSelect = NO;
                button.activityKey = key;
                button.activityValue= obj;
                
                [button addTarget:self action:@selector(postxuangxiangClick:) forControlEvents:UIControlEventTouchUpInside];
                
                [self.selectView addSubview:button];
                
                index ++;
            }];
            
            for (int i = 0; i < row; i ++) {
                selectHeight += (btn_h + y_space);
            }
            
        }
        
        self.selectView.frame = CGRectMake(0, CGRectGetMaxY(self.titleLab.frame), KScreenWidth, selectHeight);
    }
    
}

- (CGFloat)cellHeight {
    return CGRectGetMaxY(self.selectView.frame);
}


-(void)postxuangxiangClick:(DZSelectTypeButton *)btn {
    
    if (btn.isSelect) {
        if ([self.userArray containsObject:btn.activityKey]) {
            
            [self.userArray removeObject:btn.activityKey];
        }
        btn.isSelect = NO;
    } else {
        if (![self.userArray containsObject:btn.activityKey]) {
            
            [self.userArray addObject:btn.activityKey];
        }
        btn.isSelect = YES;
    }
    
    if (self.senduserBlock) {
        self.senduserBlock(self.userArray);
    }
}

- (NSMutableArray *)userArray {
    if (!_userArray) {
        _userArray = [NSMutableArray array];
    }
    return _userArray;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
