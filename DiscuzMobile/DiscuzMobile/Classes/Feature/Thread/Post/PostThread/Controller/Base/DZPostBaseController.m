//
//  DZPostBaseController.m
//  DiscuzMobile
//
//  Created by HB on 2017/6/29.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import "DZPostBaseController.h"
#import "UIAlertController+Extension.h"
#import "ZHPickView.h"
#import "DZImagePickerView.h"

@interface DZPostBaseController ()

@end

@implementation DZPostBaseController

- (void)viewWillDisappear:(BOOL)animated {
    if (self.typeArray.count > 0) {
        [self.pickView remove];
    }
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.authModel.threadtypes.types.allValues.count) {
        NSMutableDictionary *typeDic = [NSMutableDictionary dictionaryWithDictionary:self.authModel.threadtypes.types];
        [typeDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            DZThreadTypeModel *model = [[DZThreadTypeModel alloc] init];
            model.typeId = key;
            model.name = [obj flattenHTMLTrimWhiteSpace:NO];
            [self.typeArray addObject:model];
        }];
        
        NSMutableArray *arr = [NSMutableArray array];
        for (DZThreadTypeModel *model in self.typeArray) {
            [arr addObject:model.name];
        }
        
        if (self.typeArray.count > 0) {
            self.pickView = [[ZHPickView alloc] initPickviewWithArray:arr isHaveNavControler:NO];
            [self.pickView setToolbarTintColor:K_Color_ToolBar];
        }
    }
    
    [self.view addSubview:self.tableView];
}

- (void)viewEndEditing {
    [self.view endEditing:YES];
    if (self.typeArray.count > 0) {
        [self.pickView remove];
    }
}



- (void)configPostSucceed:(DZBaseResModel *)resModel tid:(NSString *)tid failure:(NSError *)error{
    
    if (resModel) {
        if (resModel.Message && resModel.Message.isSuccessed && tid.length) {
            [self.navigationController popViewControllerAnimated:NO];
            if (self.pushDetailBlock) {
                self.pushDetailBlock(tid);
            }
            return;
        }
        
        if (resModel.Message.isGroup_Nopermission && resModel.Message.messagestr.length) {
            [UIAlertController alertTitle:@"提示" message:resModel.Message.messagestr controller:self doneText:@"确定" cancelText:nil doneHandle:^{
                [self.navigationController popViewControllerAnimated:YES];
            } cancelHandle:nil];
            return;
        }
        
        [MBProgressHUD showInfo:resModel.Message.messagestr];
        
    }else{
        [self showServerError:error];
    }
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text hasEmoji]) {
        return NO;
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string hasEmoji]) {
        return NO;
    }
    return YES;
}

- (DZSecVerifyView *)verifyView {
    if (!_verifyView) {
        _verifyView = [[DZSecVerifyView alloc] init];
    }
    return _verifyView;
}

- (DZImagePickerView *)pickerView {
    if (_pickerView == nil) {
        _pickerView = [[DZImagePickerView alloc] init];
        _pickerView.navigationController = self.navigationController;
    }
    return _pickerView;
}

- (NSMutableArray<DZThreadTypeModel *> *)typeArray {
    if (!_typeArray) {
        _typeArray = [NSMutableArray array];
    }
    return _typeArray;
}

@end





