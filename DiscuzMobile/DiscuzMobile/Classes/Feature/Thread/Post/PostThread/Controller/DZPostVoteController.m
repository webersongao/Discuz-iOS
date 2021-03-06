//
//  DZPostVoteController.m
//  DiscuzMobile
//
//  Created by gensinimac1 on 15/5/13.
//  Copyright (c) 2015年 comsenz-service.com. All rights reserved.
//

#import "DZPostVoteController.h"
#import "QRadioButton.h"
#import "QCheckBox.h"
#import "PostVoteModel.h"
#import "DZVoteTitleCell.h"
#import "DZPostSelectTypeCell.h"
#import "DZVoteSelectCell.h"
#import "DZVoteContentCell.h"
#import "DZVoteDayVisableCell.h"
#import "AllOneButtonCell.h"
#import "DZActiveDetailCell.h"


#import "DZImagePickerView.h"
#import "ZHPickView.h"
#import "DZPostNetTool.h"


@interface DZPostVoteController ()<UITextFieldDelegate, UITextViewDelegate, QRadioButtonDelegate, QCheckBoxDelegate, ZHPickViewDelegate>

@property (nonatomic, strong) PostVoteModel *voteModel;
@property (nonatomic, assign) NSInteger imgBtnTag;
@property (nonatomic, strong) NSMutableDictionary *pollImageDic;

@end

static int voteIndex = 0 ;

@implementation DZPostVoteController

- (NSMutableDictionary *)pollImageDic {
    if (!_pollImageDic) {
        _pollImageDic = [NSMutableDictionary dictionary];
    }
    return _pollImageDic;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.imgBtnTag = 0;
    self.dz_NavigationItem.title = @"发起投票";
    
    self.tableView = [[DZBaseTableView alloc] initWithFrame:KView_OutNavi_Bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 80)];
    
    for (int i = 0 ; i < 2; i++) {
        [self.dataSourceArr addObject:[self voteContenView]];
    }
    
    if (self.typeArray.count > 0) {
        self.pickView.delegate = self;
    }
    [self.view addSubview:self.tableView];
    
}

#pragma mark ZhpickVIewDelegate

-(void)toolbarDidButtonClick:(ZHPickView *)pickView resultString:(NSString *)resultString androw:(NSInteger)row {
    
    self.voteModel.typeId = self.typeArray[row].typeId;
    
    DZPostSelectTypeCell *cell  = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    cell.selectField.text = resultString;
    
}

//  投票项 和 上传图片按钮 放在一个View
-(DZVoteContentCell *)voteContenView{
    
    NSString *CellIdentifier = [NSString stringWithFormat:@"contentcell"];
    DZVoteContentCell *contentCell = [[DZVoteContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    contentCell.textField.tag = voteIndex + 100;
    contentCell.postImageBtn.tag = voteIndex + 200;
    [contentCell.postImageBtn addTarget:self action:@selector(openMenu:) forControlEvents:UIControlEventTouchUpInside];
    contentCell.textField.delegate = self;
    voteIndex ++;
    return contentCell;
}


#pragma mark - tableView delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
    else if (indexPath.section == 1) {
        return 55.0;
    }
    else if (indexPath.section == 2) {
        
        return 130.0 + 45;
        
    } else {
        
        return 55.0;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1) {
        return 76.0;
    }else{
        return 0.1;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    if (section == 1) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        UILabel *tipslabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 140, 20)];
        tipslabel.text = @"向左滑动删除选项";
        tipslabel.textAlignment = NSTextAlignmentLeft;
        tipslabel.textColor = [UIColor redColor];
        tipslabel.font = [UIFont systemFontOfSize:13.0];
        [view addSubview:tipslabel];
        
        UIView *addView = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(tipslabel.frame) + 5, KScreenWidth - 20, 40)];
        addView.backgroundColor = [UIColor whiteColor];
        addView.layer.borderWidth = 1;
        addView.layer.borderColor = K_Color_Theme.CGColor;
        addView.layer.cornerRadius = 6;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addOption)];
        [addView addGestureRecognizer:tap];
        [view addSubview:addView];
        
        //        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //        addBtn.frame = CGRectMake((WIDTH - 20) / 2 - 50, 5, 100, 30);
        //        [addBtn setImage:[UIImage imageNamed:@"vote_add"] forState:UIControlStateNormal];
        //        //添加  一个选项
        //        [addBtn addTarget:self action:@selector(addOption) forControlEvents:UIControlEventTouchUpInside];
        //        [addView addSubview:addBtn];
        UILabel *addLab = [[UILabel alloc] init];
        addLab.frame = CGRectMake((KScreenWidth - 20) / 2 - 50, 5, 100, 30);
        addLab.text = @"＋ 添加一项";
        addLab.textAlignment = NSTextAlignmentCenter;
        addLab.font = [UIFont boldSystemFontOfSize:18.0];
        addLab.textColor = K_Color_Theme;
        
        
        [addView addSubview:addLab];
        
        return view;
    }
    return nil;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    if (section == 0) {
        
        if (self.typeArray.count > 0) {
            return 3;
        } else {
            return 2;
        }
    }
    
    if (section == 1) {
        
        return self.dataSourceArr.count;
    }
    
    return 1;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    switch (indexPath.section) {
        case 0: {
            
            if (indexPath.row == 0) {
                
                NSString *titleid = @"titleid";
                DZVoteTitleCell *titleCell = [tableView dequeueReusableCellWithIdentifier:titleid];
                if (titleCell == nil) {
                    titleCell = [[DZVoteTitleCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:titleid];
                }
                titleCell.titleTextField.delegate = self;
                titleCell.titleTextField.tag = 1000 + 1;
                return titleCell;
            } else {
                
                NSString *CellId = @"detailId";
                
                if (self.typeArray.count > 0) {
                    
                    if (indexPath.row == 1) {
                        
                        NSString *typesId = @"selectTypeId";
                        DZPostSelectTypeCell *typeCell = [tableView dequeueReusableCellWithIdentifier:typesId];
                        if (typeCell == nil) {
                            typeCell = [[DZPostSelectTypeCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:typesId];
                            typeCell.selectField.inputView = self.pickView;
                        }
                        typeCell.selectField.delegate = self;
                        typeCell.selectField.tag = 1003;
                        return typeCell;
                    } else {
                        
                        DZActiveDetailCell *detailCell = [tableView dequeueReusableCellWithIdentifier:CellId];
                        if (detailCell == nil) {
                            detailCell = [[DZActiveDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellId];
                        }
                        detailCell.detailTextView.delegate = self;
                        detailCell.detailTextView.placeholder = @" 详细描述";
                        detailCell.detailTextView.text = self.voteModel.message;
                        return detailCell;
                    }
                    
                    
                } else {
                    
                    DZActiveDetailCell *detailCell = [tableView dequeueReusableCellWithIdentifier:CellId];
                    if (detailCell == nil) {
                        detailCell = [[DZActiveDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellId];
                    }
                    detailCell.detailTextView.delegate = self;
                    detailCell.detailTextView.placeholder = @" 详细描述";
                    detailCell.detailTextView.text = self.voteModel.message;
                    return detailCell;
                }
            }
            
        }
            break;
            
        case 1: {
            
            DZVoteContentCell *contentCell = [self.dataSourceArr objectAtIndex:indexPath.row];
            
            return  contentCell;
            
            
        }
            break;
        case 2: {
            
            NSString *dayid = @"dayid";
            DZVoteDayVisableCell *dayVisableCell = [tableView dequeueReusableCellWithIdentifier:dayid];
            if (dayVisableCell == nil) {
                dayVisableCell = [[DZVoteDayVisableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:dayid];
                dayVisableCell.checkBox.delegate = self;
                dayVisableCell.checkBox1.delegate = self;
                dayVisableCell.dayNumTextField.delegate = self;
                dayVisableCell.dayNumTextField.tag = 10009;
                dayVisableCell.selectNumTextField.delegate = self;
                dayVisableCell.selectNumTextField.tag = 10010;
                
            }
            return  dayVisableCell;
            
        }
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


-(void)addOption {
    if (self.dataSourceArr.count >= 20) {
        [MBProgressHUD showInfo:@"最多添加20个选项"];
        return;
    }
    [self.dataSourceArr addObject:[self voteContenView]];
    
    NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.dataSourceArr.count - 1 inSection:1];
    [indexPaths addObject: indexPath];
    
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
    [self.tableView endUpdates];
    [self.tableView reloadData];
}


#pragma mark - 删除某一行
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        return UITableViewCellEditingStyleDelete;
    }
    return UITableViewCellEditingStyleNone;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [self.tableView setEditing:YES animated:animated];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (indexPath.section == 1) {
            if (self.dataSourceArr.count == 2) {
                [MBProgressHUD showInfo:@"最少两个选项"];
            } else {
                
                DZVoteContentCell *contentCell = [self.dataSourceArr objectAtIndex:indexPath.row];
                NSInteger tag = contentCell.postImageBtn.tag;
                if (self.pollImageDic.count > 0) {
                    [self.pollImageDic removeObjectForKey:[NSString stringWithFormat:@"%ld",tag]];
                }
                
                [self.dataSourceArr removeObjectAtIndex:indexPath.row];
                
                //                if (self.aidArray.count > indexPath.row) {
                //                    
                //                    
                //                    [self.aidArray removeObjectAtIndex:indexPath.row];
                ////                    [self.pollImageDic.copy removeObjectForKey:<#(nonnull id)#>]
                //                    
                //                    
                //                }
                
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                //                [self.tableView reloadData];
                [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
            }
            
        }
        
    }
}


#pragma mark - 提交投票内容
// 提交 投票
-(void)postBtn:(UIButton *)btn
{
    [self.view endEditing:YES];
    if (![self isLogin]) {
        return;
    }
    
    [self postData];
}

-(void)postData {
    
    if (![DataCheck isValidString:self.voteModel.subject]) {
        [MBProgressHUD showInfo:@"请填写标题"];
        return;
    }
    
    if (![DataCheck isValidString:self.voteModel.selectNum]) {
        [MBProgressHUD showInfo:@"请输入最多可选项"];
        return;
    }
    
    self.voteModel.polloptionArr = [NSMutableArray array];
    
    for (int i = 0; i < self.dataSourceArr.count; i ++) {
        DZVoteContentCell *cell = self.dataSourceArr[i];
        if (![DataCheck isValidString:cell.textField.text]) {
            [MBProgressHUD showInfo:@"投票选项为空请重新填写"];
            return;
        } else {
            [self.voteModel.polloptionArr addObject:cell.textField.text];
        }
    }
    
    [self downlodyan];
}
- (void)postVote {
    
    DLog(@"%@ ---- %@ --- %@",self.voteModel.checkArr ,self.voteModel.radioValue,self.voteModel.polloptionArr);
    
    NSArray *pollImageArr = nil;
    if (self.pollImageDic.count > 0) {
        pollImageArr = [self getPollImageArr];
    }
    NSDictionary  * postDic =[self.voteModel creatVoteDictdata:self.verifyView voteArr:pollImageArr];
    [self.HUD showLoadingMessag:@"发布中" toView:self.view];
    self.HUD.userInteractionEnabled = YES;
    [DZPostNetTool DZ_PublistPostThread:self.authModel.forum.fid postDict:postDic completion:^(DZBaseResModel *resModel,NSString *tidStr,NSError *error) {
        [self.HUD hide];
        [self configPostSucceed:resModel tid:tidStr failure:error];
    }];
}

- (NSArray *)getPollImageArr {
    NSInteger t = 0;
    for (DZVoteContentCell *cell in self.dataSourceArr) {
        NSString *key = [NSString stringWithFormat:@"%ld",cell.postImageBtn.tag];
        if ([self.pollImageDic objectForKey:key] == nil) {
            [self.pollImageDic setValue:[NSString stringWithFormat:@"-%ld",t] forKey:key];
            t ++;
        }
    }
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionary];
    [self.pollImageDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [resultDic setValue:key forKey:obj];
    }];
    
    NSArray *keyArr = [resultDic keysSortedByValueUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        if ([obj1 integerValue] > [obj2 integerValue]) {
            return 1;
        } else if ([obj1 integerValue] == [obj2 integerValue]) {
            
            return 0;
        }
        else {
            return -1;
        }
    }];
    
    return keyArr;
}

#pragma mark - 验证码
- (void)downlodyan {
    
    [self.verifyView downSeccode:@"post" success:^{
        if (self.verifyView.isyanzhengma) {
            [self.verifyView show];
        } else {
            [self postVote];
        }
    } failure:^(NSError *error) {
        [self showServerError:error];
    }];
    
    KWEAKSELF;
    self.verifyView.submitBlock = ^{
        [weakSelf postVote];
    };
}

- (void)openMenu:(UIButton *)sender {
    
    [self.view endEditing:YES];
    KWEAKSELF;
    self.pickerView.finishPickingBlock = ^(UIImage *image) {
        [weakSelf uploadImage:image andTag:sender.tag];
    };
    [self.pickerView openSheet];
    
}

- (void)uploadImage:(UIImage *)image  andTag:(NSInteger)tag{
    //    NSData *data;
    //    if (UIImagePNGRepresentation(image) == nil)
    //    {
    //        data = UIImageJPEGRepresentation(image, 1.0);
    //    }
    //    else
    //    {
    //        data = UIImagePNGRepresentation(image);
    //    }
    //    
    //    //图片保存的路径
    //    //这里将图片放在沙盒的documents文件夹中
    //    NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    //    //文件管理器
    //    NSFileManager *fileManager = [NSFileManager defaultManager];
    //    
    //    //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
    //    [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
    //    [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:@"/image.png"] contents:data attributes:nil];
    //    
    //    //        得到选择后沙盒中图片的完整路径
    //    _filePath = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath,  @"/image.png"];
    self.imgBtnTag = tag;
    NSArray * imagear = [NSArray arrayWithObject:image];
    
    if (![DataCheck isValidString:self.authModel.allowperm.uploadhash]) {
        [MBProgressHUD showInfo:@"无权限上传图片"];
        return;
    }
    
    NSDictionary *dic=@{@"hash":self.authModel.allowperm.uploadhash,
                        @"uid":[DZMobileCtrl sharedCtrl].Global.member_uid,
    };
    NSDictionary * getdic=@{@"fid":self.authModel.forum.fid,
                            @"operation":@"poll"};
    
    [self.HUD showLoadingMessag:@"上传图片" toView:self.view];
    [[DZPostNetTool sharedTool] DZ_UpLoadAttachmentArr:imagear attacheType:DZAttacheVote getDic:getdic postDic:dic complete:^{
        [self.HUD hideAnimated:YES];
    } success:^(id response) {
        
        if ([DataCheck isValidDict:response]) {
            NSString *aid = [response stringForKey:@"aid"];
            [self.pollImageDic setValue:aid forKey:[NSString stringWithFormat:@"%ld",self.imgBtnTag]];
            
            UIButton *imgbtn = [self.view viewWithTag:self.imgBtnTag];
            [imgbtn setBackgroundImage:image forState:UIControlStateNormal];
            
            return;
        }
        [MBProgressHUD showInfo:@"上传失败！"];
        
    } failure:^(NSError *error) {
        [self showServerError:error];
        DLog(@"%@",error);
    }];
}


#pragma mark - TextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.tag == 1001) {
        self.voteModel.subject = textField.text;
    }
    if (textField.tag==10009) {
        self.voteModel.dayNum = textField.text;
    }
    if (textField.tag==10010) {
        self.voteModel.selectNum = textField.text;
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if (textField.tag==1003) {
        [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
    } else {
        [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}
- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField.tag == 1001) {
        return YES;
    }
    // 限制输入
    if (textField.tag == 10009) {
        NSUInteger lengthOfString = string.length;
        for (NSInteger loopIndex = 0; loopIndex < lengthOfString; loopIndex++) {//只允许数字输入
            unichar character = [string characterAtIndex:loopIndex];
            if (character < 48) return NO; // 48 unichar for 0
            if (character > 57) return NO; // 57 unichar for 9
        }
        NSUInteger proposedNewLength = textField.text.length - range.length + string.length;
        if (proposedNewLength > 3) return NO;
    }
    
    // Check for total length
    NSUInteger proposedNewLength = textField.text.length - range.length + string.length;
    if (proposedNewLength > 15) return NO;//限制长度为15
    return YES;
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    self.voteModel.message = textView.text;
}

#pragma mark - QRadioButtonDelegate
- (void)didSelectedRadioButton:(QRadioButton *)radio groupId:(NSString *)groupId {
    self.voteModel.radioValue = radio.titleLabel.text;
    
}

#pragma mark - QCheckBoxDelegate
- (void)didSelectedCheckBox:(QCheckBox *)checkbox checked:(BOOL)checked {
    if (checked) {
        [self.voteModel.checkArr addObject:checkbox.titleLabel.text];
        self.voteModel.isVisibleResult=YES;
    }else{
        [self.voteModel.checkArr removeObject:checkbox.titleLabel.text];
        self.voteModel.isVisibleParticipants=YES;
    }
}

- (PostVoteModel *)voteModel {
    if (_voteModel == nil) {
        _voteModel = [[PostVoteModel alloc] init];
        _voteModel.selectNum = @"1";
    }
    return _voteModel;
}

@end
