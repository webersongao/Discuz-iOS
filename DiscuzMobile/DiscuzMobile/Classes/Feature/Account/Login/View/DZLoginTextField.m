//
//  DZLoginTextField.m
//  DiscuzMobile
//
//  Created by ZhangJitao on 16/9/17.
//  Copyright © 2016年 comsenz-service.com. All rights reserved.
// 这个textfiled高度55

#import "DZLoginTextField.h"

@interface DZLoginTextField()

@property (nonatomic,strong) UIView * leftview;
@property (nonatomic,strong) UILabel *lineLabel;
@property (nonatomic,strong) UIImageView *imgView;
@end

@implementation DZLoginTextField

- (instancetype)initWithLeft:(UIImage *)leftImg
{
    self = [super init];
    if (self) {
        [self p_setLoginTextField:leftImg];
    }
    return self;
}

- (void)p_setLoginTextField:(UIImage *)leftImg {
    
    self.backgroundColor = [UIColor whiteColor];
    //用户名
    _userNameTextField= [[UITextField alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - 1)];
    _userNameTextField.placeholder = @"请输入用户名";
    _userNameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self addSubview:_userNameTextField];
    
    _leftview =[[UIView alloc] initWithFrame:CGRectMake(8, 0, 35, 20)];
    _imgView = [[UIImageView alloc] initWithImage:(leftImg ? leftImg : KImageNamed(@"new_head_dark"))];
    
    [_leftview addSubview:_imgView];
    _userNameTextField.leftView = _leftview;
    _imgView.hidden = _imgView.image ? NO : YES;
    _userNameTextField.leftViewMode = UITextFieldViewModeAlways;
    _userNameTextField.font = [DZFontSize HomecellNameFontSize16];//14
    ;
    
   _lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.frame) - 1, CGRectGetWidth(self.frame), 1)];
    _lineLabel.backgroundColor = K_Color_Line;
    [self addSubview:_lineLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _userNameTextField.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - 1);
    _leftview.frame = CGRectMake(0, 0, 35, 24);
    _imgView.frame = CGRectMake(0, 0, CGRectGetHeight(self.leftview.frame), CGRectGetHeight(self.leftview.frame));
    _lineLabel.frame = CGRectMake(0, CGRectGetHeight(self.frame) - 1, CGRectGetWidth(self.frame), 1);
    
}

@end
