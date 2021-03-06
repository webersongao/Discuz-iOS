//
//  DZSettingController.m
//  DiscuzMobile
//
//  Created by gensinimac1 on 15/5/5.
//  Copyright (c) 2015年 comsenz-service.com. All rights reserved.
//

#import "DZSettingController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <ShareSDKExtension/ShareSDK+Extension.h>
#import "DZPushCenter.h"
#import "DZEmailHelper.h"

@interface DZSettingController ()
@property (nonatomic,copy) NSString * strcache;
@property (nonatomic, strong) NSMutableArray *listArray;  //!< <#属性注释#>
@end

@implementation DZSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dz_NavigationItem.title = @"通用设置";
    self.dataSourceArr = self.listArray.copy;
    
    self.tableView = [[DZBaseTableView alloc] initWithFrame:KView_OutNavi_Bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSourceArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr = self.dataSourceArr[section];
    return arr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellId = @"SettingCellId";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    
    if (cell == nil) {
        cell = [[DZBaseTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellId];
        cell.textLabel.font = KFont(14);
        cell.detailTextLabel.font = KFont(11);
        if (indexPath.section == 0 && indexPath.row == 0) {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
    }
    
    NSArray *settingArr = self.dataSourceArr[indexPath.section];
    cell.textLabel.text = [settingArr objectAtIndex:indexPath.row];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            UISwitch * sw = [[UISwitch alloc] init];
            [sw addTarget:self action:@selector(switchModeAction:) forControlEvents:UIControlEventValueChanged];
            [sw setOn:[[DZMobileCtrl sharedCtrl] isGraphFree]];
            cell.accessoryView = sw;
        } else if (indexPath.row == 1) {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2fM",[[DZFileManager shareInstance] filePathSize]];
        }
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5.f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.section) {
        case 0: {
            if (indexPath.row == 1) {
                [self  clearAPP];
            }
            if (indexPath.row == 2) {
                [self setDomain];
                return;
            }
            NSArray *settingArr = self.dataSourceArr[indexPath.section];
            if (settingArr.count > 1 && indexPath.row == settingArr.count - 1) {
                
            }
        }
            break;
        case 1: {
            if (indexPath.row == 0) {
                [self sendEmail];
            }
            if (indexPath.row == 1) {
                [self evaluateAPP];
            }
            if (indexPath.row == 2) {
                [self shareAPP];
            }
        }
            break;
        case 2: {
            if (indexPath.row == 0) {
                [self aboutAPP];
            }
            if (indexPath.row == 1) {
                [self userTerms];
            }
        }
            break;
        default:
            break;
    }
}

- (void)sendEmail {
    [DZEmailHelper Helper].navigationController = self.navigationController;
    [[DZEmailHelper Helper] prepareSendEmail];
}

- (void)setDomain {
    [[DZMobileCtrl sharedCtrl] PushToDomainSettingController];
}

- (void)evaluateAPP {
    [[DZMobileCtrl sharedCtrl] PushToAppStoreWebview];
}

- (void)shareAPP {
    [[DZMobileCtrl sharedCtrl] shareMyMobileAPPWithView:self.view];
}

- (void)aboutAPP {
    [[DZMobileCtrl sharedCtrl] PushToAppAboutViewController];
}

- (void)userTerms {
    [[DZMobileCtrl sharedCtrl] PushToUsertermsController];
}

#pragma mark - 无图浏览设置
-(void)switchModeAction:(UISwitch *)switchButton{
    BOOL isButtonOn = [switchButton isOn];
    [[NSUserDefaults standardUserDefaults] setBool:isButtonOn forKey:DZ_BoolNoImage];
    [[NSNotificationCenter defaultCenter] postNotificationName:DZ_ImageOrNot_Notify object:nil];
}

#pragma mark - 推送开启关闭设置
-(void)notifySwitchAction:(UISwitch *)switchButton{
    
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        //开启
        [[DZPushCenter shareInstance] Reregistration];
        
        if (![DZLoginModule isLogged]) {
            return;
        } else {
            [[DZPushCenter shareInstance] configPush];
        }
        //        if ([XGPush isUnRegisterStatus]) {
        //            [MBProgressHUD showInfo:@"开启推送"];
        //        } else {
        //            [MBProgressHUD showInfo:@"开启推送失败"];
        //        }
    } else {
        // 注销
        [self logoutDevice];
    }
}

- (void)logoutDevice{
    
    //    [XGPush unRegisterDevice];
    //    [XGPush setAccount:@"**"];
    //    if ([XGPush isUnRegisterStatus]) {
    //        [MBProgressHUD showInfo:@"注销设备"];
    //    }else {
    //        [MBProgressHUD showInfo:@"注销设备失败"];
    //    }
}

#pragma mark - 清除缓存
-(void)clearAPP {
    [self.HUD showLoadingMessag:@"正在清理" toView:self.view];
    KBack_ThreadBlock(^{
        NSString *cachPath = [JTCacheManager sharedInstance].JTKitPath;
        NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
        for (NSString *p in files) {
            NSError * error;
            NSString * path = [cachPath stringByAppendingPathComponent:p];
            if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
            }
        }
        [self cleanSaveImages];
        // 清除完，重新创建文件夹、重新创建数据库
        [[JTCacheManager sharedInstance] createDirectoryAtPath:[JTCacheManager sharedInstance].JTAppCachePath];
        [[DZDatabaseHandle Helper] openDB];
        KMain_ThreadBlock(^{
            UIImage *image = [[UIImage imageNamed:@"Checkmark"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
            self.HUD.customView = imageView;
            self.HUD.mode = MBProgressHUDModeCustomView;
            self.HUD.label.text = @"清理成功！";
        });
        sleep(2);
        [self performSelectorOnMainThread:@selector(clearCacheSuccess) withObject:nil waitUntilDone:YES];
    });
    
}
// 清除缓存(清除sdWebImage的缓存)
- (void)cleanSaveImages {
    [[SDWebImageManager sharedManager] cancelAll];
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
    [[SDImageCache sharedImageCache] clearMemory];
}

-(void)clearCacheSuccess {
    [self.HUD hide];
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:1 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationNone];
}

-(NSMutableArray *)listArray{
    if (_listArray == nil) {
        _listArray = [NSMutableArray array];
        NSMutableArray *setArr = @[@"无图浏览模式",
                                   @"清除程序缓存",
                                   @"切换网站",
        ].mutableCopy;
        NSArray *appArr = @[
            @"反馈问题",
            @"评价应用",
            @"分享应用"];
        NSArray *aboutArr = @[[NSString stringWithFormat:@"关于“%@”",DZ_APPNAME],
                              @"服务条款"];
        _listArray = @[setArr,appArr,aboutArr].mutableCopy;
    }
    return _listArray;
}


@end
