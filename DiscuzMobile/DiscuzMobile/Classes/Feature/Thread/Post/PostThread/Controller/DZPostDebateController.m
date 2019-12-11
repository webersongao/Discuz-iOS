//
//  DZPostDebateController.m
//  DiscuzMobile
//
//  Created by HB on 2017/6/23.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import "DZPostDebateController.h"
#import "UIAlertController+Extension.h"
#import "AllOneButtonCell.h"
#import "DZVoteTitleCell.h"
#import "DZPostSelectTypeCell.h"
#import "DZActiveDetailCell.h"
#import "DZViewpointCell.h"
#import "DZEndtimeCell.h"
#import "DZRefereeCell.h"
#import "ZHPickView.h"
#import "DZPostNetTool.h"
#import "PostDebateModel.h"


@interface DZPostDebateController () <ZHPickViewDelegate, UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic, copy) NSString *detail;

@property (nonatomic, strong) PostDebateModel *debateModel;

@end

@implementation DZPostDebateController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"发起辩论";
    
    self.tableView = [[DZBaseTableView alloc] initWithFrame:CGRectMake(0, KNavi_ContainStatusBar_Height, KScreenWidth, KScreenHeight - KNavi_ContainStatusBar_Height) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 80)];
    
    
    if (self.typeArray.count > 0) {
        self.pickView.delegate = self;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        
        if (self.typeArray.count > 0) {
            return 3;
        } else {
            return 2;
        }
    }
    
    if (section == 2) {
        
        return 2;
    }
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (self.typeArray.count > 0) {
            if (indexPath.row == 2) {
                return 90;
            }
        } else if (indexPath.row == 1) {
            return 90;
        }
        return 55;
    }
    if (indexPath.section == 1) {
        return 255;
    }
    if (indexPath.section == 2) {
        return 55;
    }
    return 55.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            if (indexPath.row == 0) {
                NSString *titleid = @"titleid";
                DZVoteTitleCell *titleCell = [tableView dequeueReusableCellWithIdentifier:titleid];
                if (titleCell == nil) {
                    titleCell = [[DZVoteTitleCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:titleid];
                }
                titleCell.titleTextField.delegate = self;
                titleCell.titleTextField.tag = 1001;
                return titleCell;
            } else {
                if (self.typeArray.count > 0) {
                    if (indexPath.row == 1) {
                        
                        NSString *typesId = @"selectTypeId";
                        DZPostSelectTypeCell *typeCell = [tableView dequeueReusableCellWithIdentifier:typesId];
                        if (typeCell == nil) {
                            typeCell = [[DZPostSelectTypeCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:typesId];
                            typeCell.selectField.inputView = self.pickView;
                        }
                        typeCell.selectField.delegate = self;
                        typeCell.selectField.tag = 3001;
                        return typeCell;
                    } else {
                        
                        return [self detailCell:tableView];
                    }
                    
                    
                } else {
                    
                    return [self detailCell:tableView];
                }
            }
            
        }
            break;
        case 1:
        {
            NSString *viewpoinId = @"viewpointid";
            DZViewpointCell *pointCell = [tableView dequeueReusableCellWithIdentifier:viewpoinId];
            if (pointCell == nil) {
                pointCell = [[DZViewpointCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:viewpoinId];
                pointCell.oppositeTextView.delegate = self;
                pointCell.positiveTextView.tag = 2002;
                pointCell.oppositeTextView.tag = 2003;
            }
            return pointCell;
        }
            break;
        case 2:
        {
            NSString *endtimeId = @"endtimeid";
            NSString *refereeId = @"refereeid";
            if (indexPath.row == 0) {
                DZEndtimeCell *timeCell = [tableView dequeueReusableCellWithIdentifier:endtimeId];
                if (timeCell == nil) {
                    timeCell = [[DZEndtimeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:endtimeId];
                    timeCell.contentTextfield.delegate =self;
                    timeCell.contentTextfield.tag = 1002;
                }
                return timeCell;
            } else {
                DZRefereeCell *refereCell = [tableView dequeueReusableCellWithIdentifier:refereeId];
                if (refereCell == nil) {
                    refereCell = [[DZRefereeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:refereeId];
                    refereCell.contentTextfield.delegate = self;
                    refereCell.contentTextfield.tag = 1003;
                }
                return refereCell;
            }
        }
            break;
            
        default: {
            NSString *btnid = @"buttonid";
            __weak typeof(self) weakself = self;
            AllOneButtonCell *btnCell = [tableView dequeueReusableCellWithIdentifier:btnid];
            if (btnCell == nil) {
                btnCell = [[AllOneButtonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:btnid];
                [btnCell.ActionBtn setTitle:@"发布" forState:UIControlStateNormal];
                btnCell.actionBlock = ^(UIButton *sender) {
                    [weakself postBtn:sender];
                };
            }
            
            return btnCell;
        }
            break;
    }
}

- (DZActiveDetailCell *)detailCell:(UITableView *)tableView {
    NSString *CellId = @"detailId";
    DZActiveDetailCell *detailCell = [tableView dequeueReusableCellWithIdentifier:CellId];
    if (detailCell == nil) {
        detailCell = [[DZActiveDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellId];
    }
    detailCell.detailTextView.delegate = self;
    detailCell.detailTextView.placeholder = @" 详细描述";
    detailCell.detailTextView.text = self.detail;
    detailCell.detailTextView.tag = 2001;
    return detailCell;
}


// 提交 辩论
-(void)postBtn:(UIButton *)btn
{
    [self.view endEditing:YES];
    
    if (![self isLogin]) {
        return;
    }
    if (![DataCheck isValidString:self.debateModel.subject]) {
        [MBProgressHUD showInfo:@"请填写标题"];
        return;
    }
    if (![DataCheck isValidString:self.debateModel.message]) {
        [MBProgressHUD showInfo:@"请填写详细描述"];
        return;
    }
    if (![DataCheck isValidString:self.debateModel.affirmpoint]) {
        [MBProgressHUD showInfo:@"请填写正方观点"];
        return;
    }
    if (![DataCheck isValidString:self.debateModel.negapoint]) {
        [MBProgressHUD showInfo:@"请填写反方观点"];
        return;
    }
    if (![DataCheck isValidString:self.debateModel.endtime]) {
        [MBProgressHUD showInfo:@"请选择结束时间"];
        return;
    }
    if (![DataCheck isValidString:self.debateModel.umpire]) {
        [MBProgressHUD showInfo:@"请填写裁判"];
        return;
    }
    [self downlodyan];
}

#pragma mark - 验证码
- (void)downlodyan {
    
    [self.verifyView downSeccode:@"post" success:^{
        if (self.verifyView.isyanzhengma) {
            [self.verifyView show];
        } else {
            [self postData];
        }
    } failure:^(NSError *error) {
        [self showServerError:error];
    }];
    
    KWEAKSELF;
    self.verifyView.submitBlock = ^{
        [weakSelf postData];
    };
    
}


- (void)postData {
    [self.view endEditing:YES];
    [self.pickView remove];
    if (![self isLogin]) {
        return;
    }
    
    NSDictionary * postdic=  [self.debateModel creatDebateDictdata:self.verifyView];
    [self.HUD showLoadingMessag:@"发送中" toView:self.view];
    [DZPostNetTool DZ_PublistPostThread:self.authModel.forum.fid postDict:postdic completion:^(DZBaseResModel *resModel,NSString *tidStr,NSError *error) {
        [self.HUD hide];
        [self configPostSucceed:resModel tid:tidStr failure:error];
    }];
}

-(void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.tag == 2001) {
        self.debateModel.message = textView.text;
    } else if (textView.tag == 2002) {
        self.debateModel.affirmpoint = textView.text;
    } else if (textView.tag == 2003) {
        self.debateModel.negapoint = textView.text;
    }
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
}


- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.tag == 1001) {
        self.debateModel.subject = textField.text;
    } else if (textField.tag == 1002) {
        self.debateModel.endtime = textField.text;
    } else if (textField.tag == 1003) {
        self.debateModel.umpire = textField.text;
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if (textField.tag==3001) {
        [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
    } else {
        [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    }
    return YES;
}

#pragma mark ZhpickVIewDelegate
- (void)toolbarDidButtonClick:(ZHPickView *)pickView resultString:(NSString *)resultString androw:(NSInteger)row {
    
    self.debateModel.typeId = self.typeArray[row].typeId;
    DZPostSelectTypeCell *cell  = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    cell.selectField.text = resultString;
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (scrollView == self.tableView) {
        [self viewEndEditing];
    }
}

- (PostDebateModel *)debateModel {
    if (_debateModel == nil) {
        _debateModel = [[PostDebateModel alloc] init];
        _debateModel.special = @"5";
    }
    return _debateModel;
}

@end
