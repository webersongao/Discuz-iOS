//
//  DZLoginController.m
//  DiscuzMobile
//
//  Created by HB on 17/1/10.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import "DZLoginController.h"
#import <ShareSDK/ShareSDK.h>
#import "DZLoginView.h"
#import "DZLoginTextField.h"
#import "ZHPickView.h"
#import "DZShareCenter.h"
#import "DZUserNetTool.h"
#import "DZLoginNetTool.h"
#import <ShareSDKExtension/ShareSDK+Extension.h>

#define DZ_TEXTHEIGHT 50

@interface DZLoginController ()<UITextFieldDelegate,ZHPickViewDelegate>
{
    BOOL m_isLoginQues;  // 是否有安全问答
}

@property (nonatomic, copy) NSString *preSalkey;
@property (nonatomic, strong) DZLoginView *loginView;

@end


@implementation DZLoginController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.loginView thirdPlatformAuth];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    m_isLoginQues = NO;
    [self configLoginController];
    [self downlodyan];
    [self setViewDelegate];
    [self setViewAction];
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
    [self.loginView.loginBtn addTarget:self action:@selector(loginBtnClickAction) forControlEvents:UIControlEventTouchUpInside];
    [self.loginView.forgetBtn addTarget:self action:@selector(findPasswordAction) forControlEvents:UIControlEventTouchUpInside];
    [self.loginView.qqBtn addTarget:self action:@selector(loginWithQQAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.loginView.wechatBtn addTarget:self action:@selector(loginWithWeiXinAction) forControlEvents:(UIControlEventTouchUpInside)];
}


-(void)configLoginController{
    self.title = @"账户登录";
    [self configNaviBar:@"注册" type:NaviItemText Direction:NaviDirectionRight];
    [self.view addSubview:self.loginView];
    // 新进来的时候初始化下
    [DZShareCenter shareInstance].bloginModel = nil;
    [[DZUserNetTool sharedTool] DZ_CheckRegisterAPIRequest];
    KWEAKSELF;
    self.loginView.authCodeView.refreshAuthCodeBlock = ^{
        [weakSelf downlodyan];
    };
}

#pragma mark - 请求成功操作
- (void)updateUserResInfo:(DZLoginResModel *)loginResModel {
    [super updateUserResInfo:loginResModel];
    [self dz_PopCurrentViewController];
}

- (void)leftBarBtnClick {
    [self.view endEditing:YES];
    NSDictionary *userInfo = @{@"type":@"cancel"};
    [[NSNotificationCenter defaultCenter] postNotificationName:DZ_ConfigSelectedIndex_Notify object:nil userInfo:userInfo];
    [super leftBarBtnClick];
}
#pragma mark - 注册
- (void)rightBarBtnClick {
    [self.view endEditing:YES];
    //    [DZShareCenter shareInstance].bloginModel = nil;
    [self dismissViewControllerAnimated:NO completion:nil];
    [[DZMobileCtrl sharedCtrl] PresentRegisterController];
}


- (void)loadSeccodeImage {
    
    [self performSelector:@selector(loadSeccodeWebView) withObject:nil afterDelay:0 inModes:@[NSRunLoopCommonModes]];
}


- (void)loadSeccodeWebView {
    [self.loginView.authCodeView loadRequestWithCodeUrl:self.verifyView.secureData.seccode];
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
            make.height.mas_equalTo(DZ_TEXTHEIGHT);
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
        m_isLoginQues = YES;
    } else {
        m_isLoginQues = NO;
    }
}

#pragma mark   /********************* 网络请求 *************************/

#pragma mark - 验证码
- (void)downlodyan {
    self.loginView.authCodeView.textField.text = nil;
    [self.verifyView downSeccode:@"login" success:^{
        if (self.verifyView.isyanzhengma) {
            [self.loginView.authCodeView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(DZ_TEXTHEIGHT);
            }];
            self.loginView.authCodeView.hidden = NO;
            [self loadSeccodeImage];
        }
    } failure:^(NSError *error) {
        [self showServerError:error];
    }];
}

#pragma mark   /********************* 交互事件 *************************/

- (void)findPasswordAction {
    
}


#pragma mark - qq登录
- (void)loginWithQQAction {
    [self.HUD showLoadingMessag:@"" toView:self.view];
    [[DZShareCenter shareInstance] loginWithQQSuccess:^(id  _Nullable postData, id  _Nullable getData) {
        [self thirdConnectWithService:postData getData:getData];
    } finish:^{
        [self.HUD hide];
    }];
}

#pragma mark - 微信登录
- (void)loginWithWeiXinAction {
    [self.HUD showLoadingMessag:@"" toView:self.view];
    [[DZShareCenter shareInstance] loginWithWeiXinSuccess:^(id  _Nullable postData, id  _Nullable getData) {
        [self thirdConnectWithService:postData getData:getData];
    } finish:^{
        [self.HUD hide];
    }];
}

#pragma mark - 账号密码登录
-(void)loginBtnClickAction {
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
    if (m_isLoginQues) {
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
    [dic setValue:[DZMobileCtrl sharedCtrl].Global.formhash forKey:@"formhash"];
    
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
    KWEAKSELF
    [DZLoginNetTool DZ_UserLginWithNameOrThirdService:dic getData:getData completion:^(DZLoginResModel *resModel) {
        [weakSelf.HUD hide];
        if (resModel) {
            if (resModel.Message && resModel.Message.isLoginEmpty) {
                [weakSelf.loginView.securityView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(DZ_TEXTHEIGHT);
                    weakSelf.loginView.securityView.hidden = NO;
                }];
                [DZMobileCtrl showAlertError:resModel.Message.messagestr];
            }else if ([DZLoginModule loginAnylyeData:resModel]){
                [weakSelf updateUserResInfo:resModel];
            }else{
               [weakSelf downlodyan];
            }
        }else{
            [DZMobileCtrl showAlertError:@"登录失败"];
        }
    }];
}

- (void)thirdConnectWithService:(NSDictionary *)dic getData:(NSDictionary *)getData {
    [self.HUD showLoadingMessag:@"" toView:self.view];
    
    [DZLoginNetTool DZ_UserLginWithNameOrThirdService:dic getData:getData completion:^(DZLoginResModel *resModel) {
        [self.HUD hide];
        if ([resModel.Variables isUserLogin]) {
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



#pragma mark   /********************* 初始化 *************************/

-(DZLoginView *)loginView{
    if (!_loginView) {
        BOOL isInstallQQ = [ShareSDK isClientInstalled:SSDKPlatformTypeQQ];
        BOOL isInstallWechat = [ShareSDK isClientInstalled:SSDKPlatformTypeWechat];
        _loginView = [[DZLoginView alloc] initWithFrame:KView_OutNavi_Bounds isQQ:isInstallQQ isWx:isInstallWechat];
    }
    return _loginView;
}


@end






