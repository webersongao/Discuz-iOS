//
//  DZRegisterController.m
//  DiscuzMobile
//
//  Created by HB on 17/1/11.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import "DZRegisterController.h"
#import "UsertermsController.h"

#import "DZRegisterView.h"
#import "DZAuthCodeView.h"
#import "DZLoginCustomView.h"
#import "DZWeb2AuthCodeView.h"

#import "XinGeCenter.h"
#import "CheckHelper.h"

@interface DZRegisterController ()
@property (nonatomic,strong) DZRegisterView *registerView;
@property (nonatomic, copy) NSString *bbrulestxt;
@end

@implementation DZRegisterController

- (void)loadView {
    [super loadView];
    _registerView = [[DZRegisterView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = _registerView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.registerView thirdPlatformAuth];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _registerView.delegate = self;
    [_registerView.registerButton addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    KWEAKSELF;
    self.registerView.authCodeView.refreshAuthCodeBlock = ^{
        [weakSelf downlodyan];
    };
    
    [self downlodyan];
    [self checkAPIModuleRequest];
    
    self.registerView.usertermsView.readTermBlock = ^ {
        [weakSelf readTerms];
    };
}

- (void)checkAPIModuleRequest {
    [self.HUD showLoadingMessag:@"" toView:self.view];
    [[CheckHelper shareInstance] checkRegisterRequestSuccess:^{
        [self.HUD hide];
    } failure:^{
        [self.HUD hide];
    }];
}

- (void)readTerms {
    UsertermsController *usertermsVc = [[UsertermsController alloc] init];
    usertermsVc.bbrulestxt = self.bbrulestxt;
    [self.navigationController pushViewController:usertermsVc animated:YES];
}

#pragma mark - 验证码
- (void)downlodyan {
    [self.verifyView downSeccode:@"register" success:^{
        if (self.verifyView.isyanzhengma) {
            [self.registerView.authCodeView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(50);
            }];
            self.registerView.authCodeView.hidden = NO;
        }
        
        self.bbrulestxt = [self.verifyView.secureData objectForKey:@"bbrulestxt"];
        
        [self loadSeccodeImage];
    } failure:^(NSError *error) {
        [self showServerError:error];
    }];
}


- (void)loadSeccodeImage {
    
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:[self.verifyView.secureData objectForKey:@"seccode"]]];
    [self.registerView.authCodeView.webview loadRequest:request];
    
}

- (void)registerBtnClick {
    
    [self.view endEditing:YES];
    if (!self.registerView.usertermsView.isAgree) {
        [MBProgressHUD showInfo:@"未同意服务条款"];
        return;
    }
    
    NSString *username = self.registerView.usernameView.userNameTextField.text;
    NSString *password = self.registerView.passwordView.userNameTextField.text;
    NSString *repass = self.registerView.repassView.userNameTextField.text;
    NSString *email = self.registerView.emailView.userNameTextField.text;
    
    if (![DataCheck isValidString:username]) {
        [MBProgressHUD showInfo:@"请输入用户名"];
        return;
    }
    if (![DataCheck isValidString:password]) {
        [MBProgressHUD showInfo:@"请输入密码"];
        return;
    }
    if (![DataCheck isValidString:repass]) {
        [MBProgressHUD showInfo:@"请在确定密码框中再次输入密码"];
        return;
    }
    if (![DataCheck isValidString:email]) {
        [MBProgressHUD showInfo:@"请输入邮箱"];
        return;
    }
    if (![password isEqualToString:repass]) {
        [MBProgressHUD showInfo:@"请确定两次输入的密码相同"];
        return;
    }
    
    [self postRegistData];
}

- (void)postRegistData {
    NSString *username = _registerView.usernameView.userNameTextField.text;
    NSString *password = _registerView.passwordView.userNameTextField.text;
    NSString *repass = _registerView.repassView.userNameTextField.text;
    NSString *email = _registerView.emailView.userNameTextField.text;
    
    NSDictionary *regKeyDic = [CheckHelper shareInstance].regKeyDic;
    if (![DataCheck isValidDictionary:regKeyDic]) {
        [self checkAPIModuleRequest];
        [MBProgressHUD showInfo:@"正在获取注册配置，请稍候"];
        return;
    }
    
    NSMutableDictionary *postData = @{[regKeyDic objectForKey:@"username"]:username,
                                      [regKeyDic objectForKey:@"password"]:password,
                                      [regKeyDic objectForKey:@"password2"]:repass,
                                      [regKeyDic objectForKey:@"email"]:email,
                                      @"formhash":[Environment sharedEnvironment].formhash,
                                      @"regsubmit":@"yes",
                                      }.mutableCopy;
    NSMutableDictionary *getData = [NSMutableDictionary dictionary];
    if (self.verifyView.isyanzhengma) {
        if ([DataCheck isValidString:self.registerView.authCodeView.textField.text]) {
            [postData setValue:self.registerView.authCodeView.textField.text forKey:@"seccodeverify"];
            [postData setValue:[self.verifyView.secureData objectForKey:@"sechash"] forKey:@"sechash"];
        }
    }
    
    DZLoginModel *bloginModel = [DZShareCenter shareInstance].bloginModel;
    if (bloginModel != nil) { // 三方登录过来的注册
        [getData setValue:bloginModel.logintype forKey:@"type"];
        [postData setValue:bloginModel.openid forKey:@"openid"];
        
        if ([bloginModel.logintype isEqualToString:@"weixin"] && [DataCheck isValidString:bloginModel.unionid]) {
            [postData setValue:bloginModel.unionid forKey:@"unionid"];
        }
        [self.HUD showLoadingMessag:@"登录中" toView:self.view];
        
    } else { // 普通注册
        [self.HUD showLoadingMessag:@"注册中" toView:self.view];
    }
    
    [DZApiRequest requestWithConfig:^(JTURLRequest *request) {
        request.urlString = [CheckHelper shareInstance].regUrl;
        request.parameters = postData;
        request.getParam = getData;
        request.methodType = JTMethodTypePOST;
    } success:^(id responseObject, JTLoadType type) {
        [self.HUD hide];
        [self setUserInfo:responseObject];
    } failed:^(NSError *error) {
        [self showServerError:error];
        [self.HUD hide];
    }];
}

@end

