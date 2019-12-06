//
//  DZPostBaseController.h
//  DiscuzMobile
//
//  Created by HB on 2017/6/29.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import "DZBaseTableViewController.h"
#import "UITextView+EmojiCheck.h"
#import "UITextField+EmojiCheck.h"
#import "DZBaseAuthModel.h"

@class SeccodeverifyView,ZHPickView,DZImagePickerView;

typedef void(^PushDetailBlock)(NSString *tid);

@interface DZPostBaseController : DZBaseTableViewController

@property (nonatomic, strong) DZBaseAuthModel *authModel;
@property (nonatomic, copy) PushDetailBlock pushDetailBlock;

@property (nonatomic ,strong) NSMutableArray<DZThreadTypeModel *> * typeArray;

@property (nonatomic, strong) ZHPickView *pickView;
// 验证码
@property (nonatomic, strong) SeccodeverifyView *verifyView;
// 相机相册
@property (nonatomic, strong) DZImagePickerView *pickerView;

- (void)viewEndEditing;

// 发帖请求失败
- (void)requestPostFailure:(NSError *)error;
// 发帖成功
- (void)requestPostSucceed:(id)responseObject;

@end
