//
//  DZLoginController.m
//  DiscuzMobile
//
//  Created by HB on 17/1/10.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import "DZLoginController.h"
#import <ShareSDK/ShareSDK.h>
#import "DZLoginModule.h"
#import "DZLoginView.h"
#import "DZLoginTextField.h"
#import "ZHPickView.h"
#import "DZShareCenter.h"
#import "XinGeCenter.h"  // 信鸽
#import "DZUserNetTool.h"
#import "DZLoginNetTool.h"
#import <ShareSDKExtension/ShareSDK+Extension.h>

#define TEXTHEIGHT 50

NSString * const debugUsername = @"debugUsername";
NSString * const debugPassword = @"debugPassword";

@interface DZLoginController ()<UITextFieldDelegate,ZHPickViewDelegate>
{
    BOOL isQCreateView;  // 是否有安全问答
}

@property (nonatomic, strong) DZLoginView *loginView;
@property (nonatomic, copy) NSString *preSalkey;

@end


@implementation DZLoginController

- (void)loadView {
    [super loadView];
    BOOL isInstallQQ = [ShareSDK isClientInstalled:SSDKPlatformTypeQQ];
    BOOL isInstallWechat = [ShareSDK isClientInstalled:SSDKPlatformTypeWechat];
    self.loginView = [[DZLoginView alloc] initWithFrame:KScreenBounds isQQ:isInstallQQ isWx:isInstallWechat];
    self.view = self.loginView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.loginView thirdPlatformAuth];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createBarBtn];
    [[DZUserNetTool sharedTool] DZ_CheckRegisterAPIRequest];
    KWEAKSELF;
    self.loginView.authCodeView.refreshAuthCodeBlock = ^{
        [weakSelf downlodyan];
    };
    
    [self downlodyan];
    [self setViewDelegate];
    [self setViewAction];
    // 新进来的时候初始化下
    [DZShareCenter shareInstance].bloginModel = nil;
    
    isQCreateView = NO;
    
#if DEBUG
    [self seupAutoButton];
#endif
}

- (void)seupAutoButton {
#if DEBUG
    if ([self isHaveFullContent]) {
        UIButton *autoFullBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        autoFullBtn.frame = CGRectMake(KScreenWidth - 60, 20, 40, 20);
        [autoFullBtn addTarget:self action:@selector(isHaveFullContent) forControlEvents:UIControlEventTouchUpInside];
        autoFullBtn.titleLabel.font = [DZFontSize messageFontSize14];
        [autoFullBtn setTitle:@"填充" forState:UIControlStateNormal];
        autoFullBtn.layer.borderWidth = 1;
        [autoFullBtn setTitleColor:K_Color_Theme forState:UIControlStateNormal];
        [self.view addSubview:autoFullBtn];
    }
#endif
}

- (BOOL)isHaveFullContent {
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    NSString *username = [userdefault objectForKey:debugUsername];
    NSString *password = [userdefault objectForKey:debugPassword];
    if ([DataCheck isValidString:username] && [DataCheck isValidString:password]) {
        self.loginView.countView.userNameTextField.text = username;
        self.loginView.pwordView.userNameTextField.text = password;
        return YES;
    }
    return NO;
}

- (void)setViewDelegate {
    self.loginView.delegate = self;
    self.loginView.pickView.delegate = self;
    self.loginView.countView.userNameTextField.delegate = self;
    self.loginView.pwordView.userNameTextField.delegate = self;
    self.loginView.securityView.userNameTextField.delegate = self;
    self.loginView.answerView.userNameTextField.delegate = self;
    self.loginView.authCodeView.textField.delegate = self;
}

- (void)setViewAction {
    [self.loginView.loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.loginView.forgetBtn addTarget:self action:@selector(findPassword:) forControlEvents:UIControlEventTouchUpInside];
    [self.loginView.qqBtn addTarget:self action:@selector(loginWithQQ) forControlEvents:(UIControlEventTouchUpInside)];
    [self.loginView.wechatBtn addTarget:self action:@selector(loginWithWeiXin) forControlEvents:(UIControlEventTouchUpInside)];
}

#pragma mark - 账号密码登录
-(void)loginBtnClick {
    [self.view endEditing:YES];
    
    NSString *username = self.loginView.countView.userNameTextField.text;
    NSString *password = self.loginView.pwordView.userNameTextField.text;
    
    if (![DataCheck isValidString:username]) {
        [MBProgressHUD showInfo:@"请输入用户名"];
        return;
    }
    if (![DataCheck isValidString:password]) {
        [MBProgressHUD showInfo:@"请输入密码"];
        return;
    }
    
    //       gei  &seccodeverify  验证码  &sechash={sechash值}    http header中加入之前获取到的saltkey,  coolkes
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:username forKey:@"username"];
    [dic setValue:password forKey:@"password"];
    [dic setValue:@"yes" forKey:@"loginsubmit"];
    if (self.verifyView.isyanzhengma) {
        [dic setValue:self.loginView.authCodeView.textField.text forKey:@"seccodeverify"];
        [dic setValue:self.verifyView.secureData.sechash forKey:@"sechash"];
    }
    if (isQCreateView) {
        NSDictionary * dicvalue = @{@"母亲的名字":@"1",
                                    @"爷爷的名字":@"2",
                                    @"父亲出生的城市":@"3",
                                    @"您其中一位老师的名字":@"4",
                                    @"您个人计算机的型号":@"5",
                                    @"您最喜欢的餐馆名称":@"6",
                                    @"驾驶执照最后四位数字":@"7"};
        
        [dic setValue:[dicvalue objectForKey:self.loginView.securityView.userNameTextField.text] forKey:@"questionid"];
        [dic setValue:self.loginView.answerView.userNameTextField.text forKey:@"answer"];
    }
    [dic setValue:[DZMobileCtrl sharedCtrl].User.formhash forKey:@"formhash"];
    
    NSMutableDictionary *getData = [NSMutableDictionary dictionary];
    if ([DZShareCenter shareInstance].bloginModel.openid != nil) { // 三方登录过来的注册
        [getData setValue:[DZShareCenter shareInstance].bloginModel.logintype forKey:@"type"];
        [dic setValue:[DZShareCenter shareInstance].bloginModel.openid forKey:@"openid"];
        
        if ([[DZShareCenter shareInstance].bloginModel.logintype isEqualToString:@"weixin"]
            && [DataCheck isValidString:[DZShareCenter shareInstance].bloginModel.unionid]) {
            [dic setValue:[DZShareCenter shareInstance].bloginModel.unionid forKey:@"unionid"];
        }
    }
    [self.HUD showLoadingMessag:@"登录中" toView:self.view];
    
    
    [DZLoginNetTool DZ_UserLginWithNameOrThirdService:dic getData:getData completion:^(DZLoginResModel *resModel) {
        [self.HUD hide];
        if (resModel) {
            if ([resModel.Message.messageval isEqualToString:Msg_loginEmpty]) {
                [self.loginView.securityView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(TEXTHEIGHT);
                    self.loginView.securityView.hidden = NO;
                }];
                [DZMobileCtrl showAlertError:resModel.Message.messagestr];
            }else{
                
                [self updateUserResInfo:resModel];
#if DEBUG
                [self saveAccount];
#endif
            }
        }else{
            [DZMobileCtrl showAlertError:@"登录失败"];
        }
    }];
}

- (void)saveAccount {
    NSString *username = self.loginView.countView.userNameTextField.text;
    NSString *password = self.loginView.pwordView.userNameTextField.text;
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    [userdefault setObject:username forKey:debugUsername];
    [userdefault setObject:password forKey:debugPassword];
    [userdefault synchronize];
}

#pragma mark - qq登录
- (void)loginWithQQ {
    [self.HUD showLoadingMessag:@"" toView:self.view];
    [[DZShareCenter shareInstance] loginWithQQSuccess:^(id  _Nullable postData, id  _Nullable getData) {
        [self thirdConnectWithService:postData getData:getData];
    } finish:^{
        [self.HUD hide];
    }];
}

#pragma mark - 微信登录
- (void)loginWithWeiXin {
    [self.HUD showLoadingMessag:@"" toView:self.view];
    [[DZShareCenter shareInstance] loginWithWeiXinSuccess:^(id  _Nullable postData, id  _Nullable getData) {
        [self thirdConnectWithService:postData getData:getData];
    } finish:^{
        [self.HUD hide];
    }];
}

- (void)thirdConnectWithService:(NSDictionary *)dic getData:(NSDictionary *)getData {
    [self.HUD showLoadingMessag:@"" toView:self.view];
    
    [DZLoginNetTool DZ_UserLginWithNameOrThirdService:dic getData:getData completion:^(DZLoginResModel *resModel) {
        [self.HUD hide];
        if (resModel) {
           [self updateUserResInfo:resModel];
        }else{
            if ([[getData objectForKey:@"type"] isEqualToString:@"weixin"]) {
                if ([ShareSDK hasAuthorized:SSDKPlatformTypeWechat]) {
                    [ShareSDK cancelAuthorize:SSDKPlatformTypeWechat result:nil];
                }
            }
        }
    }];
}

#pragma mark - 请求成功操作
- (void)updateUserResInfo:(DZLoginResModel *)loginResModel {
    
    if (![loginResModel isBindThird]) {
        // 去第三方绑定页面
        [self boundThirdview];
    } else {
        [super updateUserResInfo:loginResModel];
    }
}


-(void)createBarBtn{
    self.title = @"账户登录";
    [self configNaviBar:@"注册" type:NaviItemText Direction:NaviDirectionRight];
}

- (void)leftBarBtnClick {
    [self.view endEditing:YES];
    NSDictionary *userInfo = @{@"type":@"cancel"};
    [[NSNotificationCenter defaultCenter] postNotificationName:DZ_configSelectedIndex_Notify object:nil userInfo:userInfo];
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 注册
- (void)rightBarBtnClick {
    [self.view endEditing:YES];
    [self registerNavview];
}

- (void)registerNavview {
    // 重置一下
    //    [DZShareCenter shareInstance].bloginModel = nil;
    [[DZMobileCtrl sharedCtrl] PushToAccountRegisterController];
}


- (void)boundThirdview {
    [[DZMobileCtrl sharedCtrl] PushToJudgeBindController];
}

- (void)findPassword:(UIButton *)sender {
    
}

#pragma mark - 验证码
- (void)downlodyan {
    
    [self.verifyView downSeccode:@"login" success:^{
        if (self.verifyView.isyanzhengma) {
            [self.loginView.authCodeView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(TEXTHEIGHT);
            }];
            self.loginView.authCodeView.hidden = NO;
            [self loadSeccodeImage];
        }
    } failure:^(NSError *error) {
        [self showServerError:error];
    }];
}

- (void)loadSeccodeImage {
    
    [self performSelector:@selector(loadSeccodeWebView) withObject:nil afterDelay:0 inModes:@[NSRunLoopCommonModes]];
}


- (void)loadSeccodeWebView {
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.verifyView.secureData.seccode]];
    [self.loginView.authCodeView.webview loadRequest:request];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField.tag==103) {
        [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
    } else {
        [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    }
    return YES;
}

#pragma mark ZhpickVIewDelegate

-(void)toolbarDidButtonClick:(ZHPickView *)pickView resultString:(NSString *)resultString androw:(NSInteger)row{
    
    self.loginView.securityView.userNameTextField.text = resultString;
    
    if ([DataCheck isValidString:resultString] && ![resultString isEqualToString:@"无安全提问"]) {
        
        [self.loginView.answerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(TEXTHEIGHT);
        }];
        self.loginView.answerView.hidden = NO;
    } else {
        [self.loginView.answerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
        self.loginView.answerView.hidden = YES;
    }
    if (![self.loginView.securityView.userNameTextField.text isEqualToString:@"无安全提问"]) {
        // 创建view
        isQCreateView = YES;
        
    } else {
        
        isQCreateView = NO;
    }
}


@end
