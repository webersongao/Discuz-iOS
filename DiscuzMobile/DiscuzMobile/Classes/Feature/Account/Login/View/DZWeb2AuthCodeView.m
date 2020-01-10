//
//  DZWeb2AuthCodeView.m
//  DiscuzMobile
//
//  Created by HB on 16/12/6.
//  Copyright © 2016年 comsenz-service.com.  All rights reserved.
//

#import "DZWeb2AuthCodeView.h"
#import "DZBaseWebView.h"

@interface DZWeb2AuthCodeView()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) DZBaseWebView *codeWebview;

@end

@implementation DZWeb2AuthCodeView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self p_setupViews];
    }
    return self;
}

- (void)p_setupViews {
    
    [self addSubview:self.textField];
    [self addSubview:self.codeWebview];
    self.backgroundColor = [UIColor whiteColor];
}

-(void)loadRequestWithCodeUrl:(NSString *)urlString{
    [self.codeWebview dz_loadBaseWebUrl:urlString back:nil];
}
- (void)tapRefreshCodeGesAction {
    self.refreshAuthCodeBlock?self.refreshAuthCodeBlock():nil;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.textField.frame = CGRectMake(0, kMargin10, self.width*0.65, self.height - kMargin10);
    self.codeWebview.frame = CGRectMake(self.width * 0.7 , kMargin10, self.width * 0.3, self.height - kMargin10);
}

-(UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, kMargin10, KScreenWidth * 0.48, 0)];
        _textField.placeholder = @"请输入验证码";
        _textField.font = KFont(14);
        [_textField setTranslatesAutoresizingMaskIntoConstraints:NO];
        _textField.borderStyle = UITextBorderStyleRoundedRect;
    }
    return _textField;
}

-(DZBaseWebView *)codeWebview{
    if (!_codeWebview) {
        _codeWebview = [[DZBaseWebView alloc] initDeviceModeWithFrame:CGRectMake(0, kMargin10, KScreenWidth * 0.3, 0)];
        _codeWebview.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _codeWebview.userInteractionEnabled = YES;
        [_codeWebview setTranslatesAutoresizingMaskIntoConstraints:NO];
        _codeWebview.scrollView.scrollEnabled = NO;
        UITapGestureRecognizer *tapges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRefreshCodeGesAction)];
        tapges.delegate = self;
        [_codeWebview addGestureRecognizer:tapges];
    }
    return _codeWebview;
}

@end
