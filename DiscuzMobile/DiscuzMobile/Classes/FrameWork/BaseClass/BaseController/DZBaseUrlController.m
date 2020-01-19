//
//  DZBaseUrlController.m
//  DiscuzMobile
//
//  Created by HB on 16/4/29.
//  Copyright © 2016年 comsenz-service.com. All rights reserved.
//

#import "DZBaseUrlController.h"
#import "DZBaseMoreMenu.h"
//#import "TYSnapshotScroll.h"
#import "DZSnapPreviewController.h"
#import "UIAlertController+WKWebAlert.h"
#import "UIAlertController+Extension.h"

@interface DZBaseUrlController ()<DZWebViewDelegate>

@property (nonatomic,strong) DZWebView *webView;
@property (nonatomic, strong) DZBaseMoreMenu *moreMenu;  //!< <#属性注释#>

@end

@implementation DZBaseUrlController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:DZ_StatusBarTap_Notify object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.moreMenu= [DZBaseMoreMenu shareInstance];
    self.moreMenu.defaultType = YES;
    [self.view addSubview:self.webView];
    
    KWEAKSELF
    [_webView dz_loadBaseWebUrl:_urlString back:^(NSString *String) {
        [UIAlertController alertTitle:nil message:String controller:self doneText:@"返回" cancelText:nil doneHandle:^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        } cancelHandle:nil];
    }];
    
    [self configNaviBar:@"dz_navi_more" type:NaviItemImage Direction:NaviDirectionRight];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusBarTappedAction:) name:DZ_StatusBarTap_Notify object:nil];
}

- (void)dz_mainwebView:(DZWebView *)webView didLoadMainTitle:(NSString *)title{
    [self setTitle:title];
}

- (void)dz_mainwebView:(DZWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation{
    [self.HUD showLoadingMessag:@"正在加载" toView:self.view];
}


- (void)dz_mainwebView:(DZWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:webView.URL];
    NSEnumerator *enumerator = [cookies objectEnumerator];
    NSHTTPCookie *cookie;
    while (cookie = [enumerator nextObject]) {
        DLog(@"WBS -- COOKIE{name: %@, value: %@}", [cookie name], [cookie value]);
    }
    [self.HUD hideAnimated:YES];
}

- (void)dz_mainwebView:(DZWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    [self.HUD hideAnimated:YES];
    if (error.code == NSURLErrorCancelled) {
        //忽略这个错误。
        return ;
    }
    [_webView setHidden:YES];
    [UIAlertController alertTitle:nil message:[error localizedDescription] controller:self doneText:@"返回" cancelText:nil doneHandle:^{
        [self.navigationController popViewControllerAnimated:YES];
    } cancelHandle:nil];
}

// 点击状态栏到顶部
- (void)statusBarTappedAction:(NSNotification*)notification {
    [self.webView.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (DZWebView *)webView {
    if (_webView == nil) {
        _webView = [[DZWebView alloc] initWithFrame:KView_OutNavi_Bounds];
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.userInteractionEnabled = YES;
        _webView.WKBaseDelegate = self;
        [_webView setOpaque:NO];
    }
    return _webView;
}

-(void)rightBarBtnClick{
    
    KWEAKSELF
    if (self.moreMenu.defaultType) {
        NSMutableArray *buttonTitleArray = [NSMutableArray array];
        [buttonTitleArray addObjectsFromArray:@[@"safari打开", @"复制链接", @"分享", @"截图", @"刷新"]];
        [self.moreMenu defaultMenuShowInViewController:self title:@"更多" message:nil buttonTitleArray:buttonTitleArray buttonTitleColorArray:nil popoverPresentationControllerBlock:^(UIPopoverPresentationController * _Nonnull popover) {
            
        } block:^(UIAlertController * _Nonnull alertController, UIAlertAction * _Nonnull action, NSInteger buttonIndex)
         {
            if (buttonIndex == 0)
            {
                if (weakSelf.urlString.length > 0)
                {
                    /*! safari打开 */
                    [self safariOpenURL:[NSURL URLWithString:weakSelf.urlString]];
                    return;
                }
                else
                {
                    [UIAlertController PAlertWithTitle:@"提示" message:@"无法获取当前链接" completion:nil];
                }
            }
            else if (buttonIndex == 1)
            {
                /*! 复制链接 */
                if (weakSelf.urlString.length > 0)
                {
                    [UIPasteboard generalPasteboard].string = weakSelf.urlString;
                    return;
                }
                else
                {
                    [UIAlertController PAlertWithTitle:@"提示" message:@"无法获取当前链接" completion:nil];
                }
            }
            else if (buttonIndex == 2)
            {
                DLog(@"WBS 点击了 2222222   ");
            }
            else if (buttonIndex == 3)
            {
                [weakSelf snapshotBtn];
            }
            else if (buttonIndex == 4)
            {
                /*! 刷新 */
                [weakSelf.webView reloadFromOrigin];
            }
        }];
    }else
    {
        [weakSelf.moreMenu customMenuShowInViewController:weakSelf
                                                title:@"更多"
                                              message:nil
                                     buttonTitleArray:@[@"小护士",@"大领导"]
                                buttonTitleColorArray:nil popoverPresentationControllerBlock:^(UIPopoverPresentationController * _Nonnull popover) {
            
        } block:^(UIAlertController * _Nonnull alertController, UIAlertAction * _Nonnull action, NSInteger buttonIndex)
         {
            DLog(@"按钮我点击啦，你自己看着办");
//            weakSelf.menuBlock ? weekSelf.menuBlock(alertController, action, buttonIndex) : NULL;
        }];
    }
}

-(void)snapshotBtn{
    KWEAKSELF
    [TYSnapshotScroll screenSnapshot:self.webView finishBlock:^(UIImage *snapShotImage) {
        UIViewController *preVc = [[DZSnapPreviewController alloc] init:snapShotImage];
        UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:preVc];
        nc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [weakSelf presentViewController:nc animated:YES completion:nil];
    }];
}


- (void)safariOpenURL:(NSURL *)URL
{
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:URL options:@{UIApplicationOpenURLOptionUniversalLinksOnly : @NO} completionHandler:^(BOOL success)
         {
             if (!success) {
                 [UIAlertController PAlertWithTitle:@"提示" message:@"打开失败" completion:nil];
             }
         }];
    } else {
        
        if (![[UIApplication sharedApplication] openURL:URL]) {
            [UIAlertController PAlertWithTitle:@"提示" message:@"打开失败" completion:nil];
        }
    }
}

@end
