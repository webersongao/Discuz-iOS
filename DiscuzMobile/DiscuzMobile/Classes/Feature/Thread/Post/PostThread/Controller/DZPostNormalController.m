//
//  DZPostNormalController.m
//  DiscuzMobile
//
//  Created by HB on 2017/6/7.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import "DZPostNormalController.h"
#import "AudioModel.h"
#import "AudioTool.h"
#import "DZPostNetTool.h"
#import "PostNormalModel.h"
#import "WSImageModel.h"
#import "DZPostSelectTypeCell.h"
#import "DZVoteTitleCell.h"
#import "DZNormalDetailCell.h"
#import "DZNormalThreadToolCell.h"
#import "DZAudioListCell.h"

#import "ZHPickView.h"

@interface DZPostNormalController () <ZHPickViewDelegate, UITextFieldDelegate, UITextViewDelegate,WBStatusComposeEmoticonViewDelegate,YYTextViewDelegate>

@property (nonatomic, strong) PostNormalModel *normalModel;

@property (nonatomic ,copy) NSString * filePath;

@property (nonatomic, strong) NSMutableArray *imageViews;

// 录音时长
@property (nonatomic, assign) NSInteger recordTime;

@property (nonatomic, strong) NSIndexPath *playingIndex;

@end

@implementation DZPostNormalController


- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)dealloc {
    [[AudioTool shareInstance] clearAudio];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dz_NavigationItem.title = @"发帖";
    
    [self configNaviBar:@"发布" type:NaviItemText Direction:NaviDirectionRight];
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    if (self.typeArray.count > 0) {
        self.pickView.delegate = self;
    }
}

- (void)rightBarBtnClick {
    
    [self.view endEditing:YES];
    
    if (![self isLogin]) {
        return;
    }
    if (![DataCheck isValidString:self.normalModel.subject]) {
        [MBProgressHUD showInfo:@"请输入标题"];
        return;
    }
    
    self.dz_NavigationItem.rightBarButtonItem.enabled = NO;
    [self downlodyan];
    
}

#pragma mark - tableView delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([AudioTool shareInstance].audioArray.count > 0) {
        return 3;
    }
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        if (self.typeArray.count > 0) {
            return 3;
        } else {
            return 2;
        }
    } else if(section == 1) {
        if ([AudioTool shareInstance].audioArray.count > 0) {
            return [AudioTool shareInstance].audioArray.count;
        }
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat keyboardHeight = 265;
    CGFloat detailH = KScreenHeight - KNavi_ContainStatusBar_Height - keyboardHeight - 55;
    if (self.typeArray.count > 0) {
        detailH -= 55;
    }
    if (indexPath.section == 0) {
        if (self.typeArray.count > 0) {
            if (indexPath.row == 2) {
                return detailH;
            }
        } else if (indexPath.row == 1) {
            return detailH;
        }
        return 55;
    }
    else if (indexPath.section == 1) {
        
        if ([AudioTool shareInstance].audioArray.count > 0) {
            return 50;
        } else {
            return keyboardHeight;
        }
        
     }else {
        if ([AudioTool shareInstance].audioArray.count > 0) {
            return keyboardHeight;
        }
        return 0;
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0: {
            if (indexPath.row == 0) {
                NSString *titleid = @"titleid";
                DZVoteTitleCell *titleCell = [tableView dequeueReusableCellWithIdentifier:titleid];
                if (titleCell == nil) {
                    titleCell = [[DZVoteTitleCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:titleid];
                }
                titleCell.titleTextField.delegate = self;
                titleCell.titleTextField.text = self.normalModel.subject;
                titleCell.titleTextField.tag = 1000 + 1;
                [titleCell.titleTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
                return titleCell;
            } else {
                if (self.typeArray.count > 0) {
                    if (indexPath.row == 1) {
                        NSString *typesId = @"selectTypeId";
                        DZPostSelectTypeCell *typeCell = [tableView dequeueReusableCellWithIdentifier:typesId];
                        if (typeCell == nil) {
                            typeCell = [[DZPostSelectTypeCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:typesId];
                            typeCell.selectField.inputView = self.pickView;
                            typeCell.selectField.tag = 1003;
                        }
                        typeCell.selectField.delegate = self;
                        return typeCell;
                    } else {
                        return [self detailCell];
                    }
                } else {
                    return [self detailCell];
                }
            }
        }
            break;
        case 1: {
            if ([AudioTool shareInstance].audioArray.count > 0) {
                AudioModel *model = [AudioTool shareInstance].audioArray[indexPath.row];
                NSString *toolId = @"audioId";
                DZAudioListCell *audioCell = [tableView dequeueReusableCellWithIdentifier:toolId];
                if (audioCell == nil) {
                    audioCell = [[DZAudioListCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:toolId];
                    audioCell.selectionStyle = UITableViewCellSelectionStyleNone;
                }
                audioCell.timeLabel.text = [NSString stringWithFormat:@"%ld秒",model.time];
                return audioCell;
            } else {
                return [self ToolCell];
            }
        }
            break;
        case 2: {
            return [self ToolCell];
        }
            break;
            
        default: {
            
        }
            break;
    }
    
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section],(long)[indexPath row]];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
    
}

- (DZNormalDetailCell *)detailCell {
    NSString *CellId = @"detailId";
    DZNormalDetailCell *detailCell = [self.tableView dequeueReusableCellWithIdentifier:CellId];
    if (detailCell == nil) {
        detailCell = [[DZNormalDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellId];
    }
    detailCell.textView.delegate = self;
    detailCell.textView.text = self.normalModel.message;
    return detailCell;
}

- (DZNormalThreadToolCell *)ToolCell {
    NSString *toolId = @"toolId";
    DZNormalThreadToolCell *toolCell = [self.tableView dequeueReusableCellWithIdentifier:toolId];
    if (toolCell == nil) {
        toolCell = [[DZNormalThreadToolCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:toolId];
        toolCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        KWEAKSELF;
        toolCell.uploadView.pickerView.navigationController = self.navigationController;
        toolCell.uploadView.pickerView.HUD = self.HUD;
        [WBEmoticonInputView sharedView].delegate = self;
        toolCell.uploadView.pickerView.finishPickingBlock = ^(NSArray *WSImageModels) {
            [weakSelf uploadImageArr:WSImageModels];
        };
        
        toolCell.hideKeyboardBlock = ^{
            [weakSelf.view endEditing:YES];
        };
        
        toolCell.recordView.uploadBlock = ^{
            [weakSelf uploadAudio];
        };
        
    }
    return toolCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([AudioTool shareInstance].audioArray.count > 0) {
        AudioModel *model = [AudioTool shareInstance].audioArray[indexPath.row];
        if (indexPath == self.playingIndex) {
            [[AudioTool shareInstance] pausePlayRecord];
            self.playingIndex = nil;
            return;
        }
        //        [self playlistAudio:model.mp3Url];
        [[AudioTool shareInstance] playlistAudio:model.mp3Url];
        self.playingIndex = indexPath;
    }
}

#pragma mark ZhpickVIewDelegate
-(void)toolbarDidButtonClick:(ZHPickView *)pickView resultString:(NSString *)resultString androw:(NSInteger)row {
    
    self.normalModel.typeId = self.typeArray[row].typeId;
    
    DZPostSelectTypeCell *cell  = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    cell.selectField.text = resultString;
    
}

#pragma mark @protocol WBStatusComposeEmoticonView
- (void)emoticonInputDidTapText:(NSString *)text {
    if (text.length) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
        if (self.typeArray.count > 0) {
            indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
        }
        DZNormalDetailCell *detailCell = [self.tableView cellForRowAtIndexPath:indexPath];
        [detailCell.textView replaceRange:detailCell.textView.selectedTextRange withText:text];
        self.normalModel.message = detailCell.textView.text;
    }
}

- (void)emoticonInputDidTapBackspace {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    if (self.typeArray.count > 0) {
        indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
    }
    DZNormalDetailCell *detailCell = [self.tableView cellForRowAtIndexPath:indexPath];
    [detailCell.textView deleteBackward];
}


-(void)postData {
    [self.view endEditing:YES];
    
    NSDictionary * postdic=  [self.normalModel creatNormalDictdata:self.verifyView toolCell:[self getToolCell]];
    [self.HUD showLoadingMessag:@"发送中" toView:self.view];
    self.HUD.userInteractionEnabled = YES;
    [DZPostNetTool DZ_PublistPostThread:self.authModel.forum.fid postDict:postdic completion:^(DZBaseResModel *resModel,NSString *tidStr,NSError *error) {
        [self.HUD hide];
        self.dz_NavigationItem.rightBarButtonItem.enabled = YES;
        [self configPostSucceed:resModel tid:tidStr failure:error];
    }];
}

-(void)configPostSucceed:(DZBaseResModel *)resModel tid:(NSString *)tid failure:(NSError *)error {
    [super configPostSucceed:resModel tid:tid failure:error];
    if (resModel.Message && resModel.Message.isSuccessed) {
        [[AudioTool shareInstance] clearAudio];
    }
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
        self.dz_NavigationItem.rightBarButtonItem.enabled = YES;
        
    }];
    
    KWEAKSELF;
    self.verifyView.submitBlock = ^{
        [weakSelf postData];
    };
    
}

- (void)uploadImageArr:(NSArray *)imageArr {
    if (![DataCheck isValidString:self.authModel.allowperm.uploadhash]) {
        [MBProgressHUD showInfo:@"无权限上传图片"];
        return;
    }
    NSMutableDictionary *dic=@{@"hash":self.authModel.allowperm.uploadhash,
                               @"uid":[NSString stringWithFormat:@"%@",[DZMobileCtrl sharedCtrl].Global.member_uid],
    }.mutableCopy;
    NSMutableDictionary * getdic=@{@"fid":self.authModel.forum.fid,
                                   @"type":@"image",
    }.mutableCopy;
    
    DZNormalThreadToolCell *cell = [self getToolCell];
    [self.HUD showLoadingMessag:@"" toView:self.view];
    [cell.uploadView uploadImageArray:imageArr.copy getDic:getdic postDic:dic];
    
}

- (DZNormalThreadToolCell *)getToolCell {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    if ([AudioTool shareInstance].audioArray.count > 0) {
        indexPath = [NSIndexPath indexPathForRow:0 inSection:2];
    }
    DZNormalThreadToolCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    return cell;
}


// 删除录音
- (void)deleteAudio:(NSIndexPath *)indexPath {
    // 删除本地文件
    AudioModel *audio = [AudioTool shareInstance].audioArray[indexPath.row];
    [[DZFileManager shareInstance] removeFileWithPath:audio.mp3Url.absoluteString];
    // 删除列表数据源
    [[AudioTool shareInstance].audioArray removeObjectAtIndex:indexPath.row];
    
    if ([AudioTool shareInstance].audioArray.count > 0) {
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
        
    } else {
        [self.tableView reloadData];
    }
}

- (void)uploadSucceed {
    self.recordTime = 0;
    [[AudioTool shareInstance] initAudio];
}

- (void)uploadAudio {
    
    NSDictionary *dic=@{@"hash":self.authModel.allowperm.uploadhash,
                        @"uid":[NSString stringWithFormat:@"%@",[DZMobileCtrl sharedCtrl].Global.member_uid],
    };
    NSDictionary * getdic=@{@"fid":self.authModel.forum.fid};
    NSArray *arr = @[[AudioTool shareInstance].mp3Url.absoluteString];
    [self.HUD showLoadingMessag:@"正在上传语音..." toView:self.view];
    [[DZPostNetTool sharedTool] DZ_UpLoadAttachmentArr:arr attacheType:DZAttacheAudio getDic:getdic postDic:dic complete:^{
        [self.HUD hide];
    } success:^(id response) {
        
        AudioModel *audio = [AudioModel audioWithId:response  andMp3Url:[AudioTool shareInstance].mp3Url];
        audio.time = [AudioTool shareInstance].recordTime;
        [[AudioTool shareInstance].audioArray addObject:audio];
        [UIView animateWithDuration:0 animations:^{
            [self.tableView reloadData];
        } completion:^(BOOL finished) {
            DZNormalThreadToolCell *cell = [self getToolCell];
            [cell.recordView resetAction];
        }];
    } failure:^(NSError *error) {
        [self showServerError:error];
    }];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([AudioTool shareInstance].audioArray.count > 0) {
        if (indexPath.section == 1) {
            return UITableViewCellEditingStyleDelete;
        }
    }
    return UITableViewCellEditingStyleNone;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    
    if ([AudioTool shareInstance].audioArray.count > 0) {
        
        [self.tableView setEditing:YES animated:animated];
    }
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if ([AudioTool shareInstance].audioArray.count > 0) {
            [self deleteAudio:indexPath];
        }
    }
}

- (void)resetScrollPosition:(YYTextView *)textView {
    CGRect r = [textView caretRectForPosition:textView.selectedTextRange.end];
    CGFloat caretY =  MAX(r.origin.y - textView.frame.size.height + r.size.height + 8, 0);
    if (textView.contentOffset.y < caretY && r.origin.y != INFINITY)
        textView.contentOffset = CGPointMake(0, caretY);
}

-(void)textViewDidEndEditing:(UITextView *)textView {
    self.normalModel.message = textView.text;
}

- (void)textViewDidChange:(YYTextView *)textView {
    [self resetScrollPosition:textView];
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.tag == 1001) {
        self.normalModel.subject = textField.text;
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if (textField.tag == 1003) {
        [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
    } else {
        [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    }
    return YES;
}

- (void)textFieldDidChange:(UITextField *)textField{
    UITextRange *selectedRange = textField.markedTextRange;
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    NSString *text = textField.text;
    if (!position) {
        // 2. 截取
        if (text.length >= 80) {
            textField.text = [text substringToIndex:80];
        }
    } else {
        // 有高亮选择的字 不做任何操作
    }
}

- (PostNormalModel *)normalModel {
    if (_normalModel == nil) {
        _normalModel = [[PostNormalModel alloc] init];
        _normalModel.subject = @"";
        _normalModel.message = @"";
    }
    return _normalModel;
}

- (NSMutableArray *)imageViews {
    if (!_imageViews) {
        _imageViews = [NSMutableArray array];
    }
    return _imageViews;
}

@end
