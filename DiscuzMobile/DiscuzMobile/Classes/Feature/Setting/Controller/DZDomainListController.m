//
//  DZDomainListController.m
//  DiscuzMobile
//
//  Created by ZhangJitao on 2018/3/30.
//  Copyright © 2018年 comsenz-service.com.  All rights reserved.
//

#import "DZDomainListController.h"
#import "UIAlertController+Extension.h"

NSString * const KDomainListKey = @"domainLisKey";
NSString * const KLocalDomainList = @"local_DomainList";

NSString * const KDomainkey = @"domain";
NSString * const KDomainNameKey = @"name";

@interface DZDomainListController ()

@end

@implementation DZDomainListController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNaviBar:@"添加" type:NaviItemText Direction:NaviDirectionRight];
    
    [self.view addSubview:self.tableView];
    self.dataSourceArr = [NSMutableArray arrayWithArray:[self localDomainData]];
}

- (void)rightBarBtnClick {

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"注意" message:@"请输入域名’http‘开头‘/’结尾" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"名称";
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"域名";
    }];
    UIAlertAction *doneAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
        UITextField *nameTextField = alertController.textFields.firstObject;
        UITextField *domainTextField = alertController.textFields.lastObject;
        if (![DataCheck isValidString:nameTextField.text]) {
            [MBProgressHUD showInfo:@"请输入名称"];
            [self showDetailViewController:alertController sender:nil];
            return;
        }
        if (![DataCheck isValidString:domainTextField.text]) {
            [MBProgressHUD showInfo:@"请输入域名"];
            [self showDetailViewController:alertController sender:nil];
            return;
        }
        NSString *domainString = domainTextField.text;
        if (![domainString hasSuffix:@"/"]) {
            domainString = [domainString stringByAppendingString:@"/"];
        }
        
        NSDictionary *dic = @{KDomainNameKey:nameTextField.text,
                              KDomainkey:domainString
                              };
        [self.dataSourceArr addObject:dic];
        [[DZFileManager shareInstance] writeDocumentPlist:@{KDomainListKey:self.dataSourceArr} fileName:KDomainListKey];
        [DZLoginModule signout];
        [[NSNotificationCenter defaultCenter] postNotificationName:DZ_DomainUrlChange_Notify object:nil];
        [self.tableView reloadData];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:doneAction];
    [alertController addAction:cancelAction];
    [self showDetailViewController:alertController sender:nil];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:NSStringFromClass([self class])];
        cell.detailTextLabel.font = [DZFontSize ActiveListFontSize11];
        cell.textLabel.font = [DZFontSize messageFontSize14];
    }
    NSDictionary *domainDic = self.dataSourceArr[indexPath.row];
    
    NSString *detail = domainDic[KDomainkey];
    NSString *nowDomain = [[NSUserDefaults standardUserDefaults] stringForKey:KRoot_Domainkey];
    if ([detail isEqualToString:nowDomain]) {
        detail = [detail stringByAppendingString:@"(当前) "];
    } else if (nowDomain == nil && [detail isEqualToString:DZ_BASEURL]) {
        detail = [detail stringByAppendingString:@"(当前) "];
    }
    cell.textLabel.text = domainDic[KDomainNameKey];
    cell.detailTextLabel.text = detail;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *domainDic = self.dataSourceArr[indexPath.row];
    NSString *detail = domainDic[KDomainkey];
    NSString *nowDomain = [[NSUserDefaults standardUserDefaults] stringForKey:KRoot_Domainkey];
    
    if (![detail isEqualToString:DZ_BASEURL] || !([DataCheck isValidString:nowDomain] && [nowDomain isEqualToString:detail])) {
        [[NSUserDefaults standardUserDefaults] setObject:detail forKey:KRoot_Domainkey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [DZLoginModule signout];
        [[NSNotificationCenter defaultCenter] postNotificationName:DZ_DomainUrlChange_Notify object:Nil];
        [tableView reloadData];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [self.tableView setEditing:YES animated:animated];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self deleteDomain:indexPath];
    }
}

- (void)deleteDomain:(NSIndexPath *)indexPath {
    
    NSDictionary *domainDic = self.dataSourceArr[indexPath.row];
    NSString *nowDomain = [[NSUserDefaults standardUserDefaults] objectForKey:KRoot_Domainkey];
    if ([domainDic[KDomainkey] isEqualToString:nowDomain]) {
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:KRoot_Domainkey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    [self.dataSourceArr removeObjectAtIndex:indexPath.row];
    [[DZFileManager shareInstance] writeDocumentPlist:@{KDomainListKey:self.dataSourceArr} fileName:KDomainListKey];
    
    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
    [self.tableView endUpdates];
}


-(NSArray *)localDomainData{
    NSArray *domainArray = nil;
    NSDictionary *dic = [[DZFileManager shareInstance] readDocumentPlist:KDomainListKey];
    if ([DataCheck isValidDict:dic] && [DataCheck isValidArray:dic[KDomainListKey]]) {
        domainArray = [dic arrayForKey:KDomainListKey];
    } else {
        NSDictionary *disDz = @{KDomainkey:@"https://bbs.comsenz-service.com/",
                                KDomainNameKey:@"掌上论坛",
                                };
        NSDictionary *devDz = @{KDomainkey:@"https://guanjia.comsenz-service.com/",
                                KDomainNameKey:@"管家测试",
                                };
        NSDictionary *wbDZ = @{KDomainkey:@"http://demo.516680.com/",
                               KDomainNameKey:@"卫博生DZ测试站",
                               };
        NSDictionary *bird = @{KDomainkey:@"https://www.birdnet.com/",
                               KDomainNameKey:@"鸟网",
                               };
        domainArray = @[disDz,devDz,bird,wbDZ];
        [[DZFileManager shareInstance] writeDocumentPlist:@{KDomainListKey:domainArray} fileName:KDomainListKey];
    }
    
    return domainArray;
}

@end






