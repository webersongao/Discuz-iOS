//
//  DZWeb2AuthCodeView.m
//  DiscuzMobile
//
//  Created by HB on 16/12/6.
//  Copyright © 2016年 comsenz-service.com.  All rights reserved.
//

#import "DZWeb2AuthCodeView.h"

@interface DZWeb2AuthCodeView()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIWebView *webview;
@end

@implementation DZWeb2AuthCodeView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self p_setupViews];
    }
    return self;
}

- (void)p_setupViews {
    
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.textField];
    [self addSubview:self.webview];
    [self setHidden:YES];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self).offset(10);
        make.width.mas_equalTo(KScreenWidth * 0.48);
        make.height.mas_equalTo(0);
    }];
    [self.webview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(0);
        make.top.equalTo(self).offset(10);
        int width = KScreenWidth * 0.3;
        make.width.mas_equalTo(width);
    }];
    
}

-(void)loadRequestWithCodeUrl:(NSString *)urlString{
    [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
}
- (void)tapGesACtion {
    self.refreshAuthCodeBlock?self.refreshAuthCodeBlock():nil;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

- (void)setHidden:(BOOL)hidden {
    [super setHidden:hidden];
    if (self.hidden == NO)  {
        [self.superview layoutIfNeeded];
        if (self.frame.size.height > 2) {
            [self.textField mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(self.frame.size.height - 16);
            }];
            [self.webview mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(self.frame.size.height - 10);
            }];
        }
    }
}


-(UIWebView *)webview{
    if (!_webview) {
        _webview = [[UIWebView alloc] init];
        _webview.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _webview.userInteractionEnabled = YES;
        [_webview setTranslatesAutoresizingMaskIntoConstraints:NO];
        _webview.scrollView.scrollEnabled = NO;
        UITapGestureRecognizer *tapges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesACtion)];
        tapges.delegate = self;
        [_webview addGestureRecognizer:tapges];
    }
    return _webview;
}

-(UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.placeholder = @"请输入验证码";
        _textField.font = KFont(14);
        [_textField setTranslatesAutoresizingMaskIntoConstraints:NO];
        _textField.borderStyle = UITextBorderStyleRoundedRect;
    }
    return _textField;
}

@end
