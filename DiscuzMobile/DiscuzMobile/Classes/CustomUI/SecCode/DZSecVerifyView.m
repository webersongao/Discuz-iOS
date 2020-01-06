//
//  DZSecVerifyView.m
//  DiscuzMobile
//
//  Created by HB on 2017/6/27.
//  Copyright © 2017年 comsenz-service.com. All rights reserved.
//

#import "DZSecVerifyView.h"
#import "MBProgressHUD.h"
#import "DZBaseWebView.h"
#import "MBProgressHUD+Add.h"

@interface DZSecVerifyView() <UIGestureRecognizerDelegate>

@property (nonatomic, assign) BOOL isCreate;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, strong) WKWebView * identWebView;

@end

@implementation DZSecVerifyView


- (void)downSeccode:(NSString *)type success:(void(^)(void))success failure:(void(^)(NSError *error))failure {
    _type = type;
    static NSInteger downYan_count = 0;
    KWEAKSELF
    [DZForumTool DZ_DownAuthSeccode:type success:^(DZSecAuthModel *authModel) {
        downYan_count = 0;
        weakSelf.secureData = authModel;
        if (authModel) {
            //  如果为空则 不需要验证码
            if (authModel.seccode.length && authModel.sechash.length) {
                self.isyanzhengma = YES;
                if (weakSelf.isCreate) {
                    [weakSelf creatSecureView];
                }
            }else{
                weakSelf.isyanzhengma = NO;
            }
        } else {
            weakSelf.isyanzhengma = NO;
        }
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (downYan_count < 2) {
            downYan_count ++;
            [weakSelf downSeccode:type success:(void(^)(void))success failure:(void(^)(NSError *error))failure];
        } else {
            downYan_count = 0;
            if (failure) { failure(error); }
        }
    }];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGBACOLOR(83, 83, 83, 0.5);
        UIWindow *window = [UIApplication sharedApplication].delegate.window;
        self.frame = window.bounds;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)];
        tap.delegate = self;
        [self addGestureRecognizer:tap];
        _isCreate = NO;
    }
    return self;
}


-(void)createYtextView {
    
    _isCreate = YES;
    
    self.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.5f];
    UIView *  bgview = [[UIView alloc]initWithFrame:CGRectMake(40, 116, KScreenWidth-80, 300)];
    if (iPhone320) {
        bgview.frame = CGRectMake(40, 80, KScreenWidth-80, 260);
    }
    
    bgview.backgroundColor = mRGBColor(241, 241, 241);
    [self addSubview:bgview];
    
    
    [bgview addSubview:self.yanTextField];
    
    //验证码webview
    _identWebView = [[DZBaseWebView alloc]initWithFrame:CGRectMake(10, 120, _yanTextField.frame.size.width/2, 40)];
    _identWebView.userInteractionEnabled = YES;
    _identWebView.backgroundColor = [UIColor yellowColor];
    UIButton * buttonSeccode = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonSeccode.frame = CGRectMake(10+_yanTextField.frame.size.width/2, 120, _yanTextField.frame.size.width/2, 40);
    [buttonSeccode addTarget:self action:@selector(downSecCodeAction) forControlEvents:UIControlEventTouchUpInside];
    buttonSeccode.layer.cornerRadius = 5;
    [buttonSeccode setTitle:@"看不清?" forState:UIControlStateNormal];
    [buttonSeccode setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [buttonSeccode setTitleColor:[UIColor darkGrayColor] forState:UIControlStateSelected];
    
    [bgview addSubview:buttonSeccode];
    
    _secqaaLabel = [[UILabel alloc] init];
    _secTextField= [[UITextField alloc] init];
    _secTextField.frame = CGRectMake(CGRectGetMinX(_identWebView.frame), CGRectGetMaxY(_identWebView.frame) + 15,CGRectGetWidth(_identWebView.frame), 0);
    _secqaaLabel.frame = CGRectMake(CGRectGetMinX(buttonSeccode.frame), CGRectGetMaxY(_identWebView.frame) + 15, CGRectGetWidth(buttonSeccode.frame), 0);
    [bgview addSubview:_secqaaLabel];
    [bgview addSubview:_secTextField];
    if (self.secureData.secqaa.length) {
        _secqaaLabel.frame = CGRectMake(CGRectGetMinX(_identWebView.frame), CGRectGetMaxY(_identWebView.frame) + 15,CGRectGetWidth(_identWebView.frame), 40);
        _secqaaLabel.font = KFont(14);
        _secqaaLabel.textAlignment = NSTextAlignmentCenter;
        
        _secTextField.frame = CGRectMake(CGRectGetMinX(buttonSeccode.frame), CGRectGetMaxY(_identWebView.frame) + 15, CGRectGetWidth(buttonSeccode.frame), 40);
        _secTextField.placeholder = @"请输入答案";
        _secTextField.tag = 10010;
        _secTextField.borderStyle= UITextBorderStyleRoundedRect;
        _secTextField.layer.borderWidth = 2.0f;
        _secTextField.layer.cornerRadius = 5;
        _secTextField.layer.borderColor = K_Color_Theme.CGColor;
        _secTextField.font = KFont(14);//14
    }
    //    _yanTextField.delegate = self;
    UIButton * buttonpost = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonpost.frame = CGRectMake(11, CGRectGetMaxY(_secTextField.frame) + 15,KScreenWidth-100, 50);
    buttonpost.backgroundColor = K_Color_Theme;
    [buttonpost addTarget:self action:@selector(postClick) forControlEvents:UIControlEventTouchUpInside];
    buttonpost.layer.cornerRadius = 5;
    [buttonpost setTitle:@"提交" forState:UIControlStateNormal];
    [buttonpost setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [buttonpost setTitleColor:[UIColor darkGrayColor] forState:UIControlStateSelected];
    //    buttonSeccode.layer.borderColor = K_Color_Theme.CGColor;
    [bgview addSubview:buttonpost];
    
    [self creatSecureView];
    [bgview addSubview:_identWebView];
    
}

- (void)downSecCodeAction {
    [self downSeccode:self.type success:nil failure:nil];
}

- (void)show {
    DLog(@"显示");
    if (!_isCreate) {
        [self createYtextView];
    }
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    [window addSubview:self];
}

- (void)close {
    DLog(@"关闭");
    [self removeFromSuperview];
}

- (void)postClick {
    if (![DataCheck isValidString:_yanTextField.text]) {
        [MBProgressHUD showInfo:@"请输入验证码"];
        return;
    }
    [self close];
    if (self.submitBlock) {
        self.submitBlock();
    }
}

-(void)creatSecureView {
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.secureData.seccode]];
    [_identWebView loadRequest:request];
    _secqaaLabel.text = self.secureData.secqaa;
}


-(UITextField *)yanTextField{
    if (!_yanTextField) {
        // 验证码field
        _yanTextField= [[UITextField alloc] initWithFrame:CGRectMake(10, 50, KScreenWidth-100, 57)];
        _yanTextField.placeholder = @"请输入验证码";
        _yanTextField.tag=10010;
        _yanTextField.borderStyle= UITextBorderStyleRoundedRect;
        _yanTextField.layer.borderWidth = 2.0f;
        _yanTextField.layer.cornerRadius = 5;
        _yanTextField.layer.borderColor = K_Color_Theme.CGColor;
        _yanTextField.font = KFont(14);//14
    }
    return _yanTextField;
}

@end
