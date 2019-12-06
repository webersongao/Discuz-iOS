//
//  CenterManageModel.m
//  DiscuzMobile
//
//  Created by HB on 2017/9/8.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import "CenterManageModel.h"
#import "TextIconModel.h"

@implementation CenterManageModel

- (instancetype)initWithType:(JTCenterType)type {
    self = [super init];
    if (self) {
        if (type == JTCenterTypeMy) {
            [self initData];
        } else if (type == JTCenterTypeOther) {
            [self initOtherData];
        }
    }
    return self;
}

- (void)initData {
    //    NSArray *mgArr = @[@"账号设置",@"修改密码",@"我的足迹", @"注册时间"];
    NSArray *mgArr = @[@"绑定管理",@"注册时间"];
    for (int i = 0; i < mgArr.count; i ++) {
        TextIconModel *model = [[TextIconModel alloc] init];
        model.text = mgArr[i];
        switch (i) {
            case 0:
                model.iconName = @"bind_icon";
                break;
            case 1:
                model.iconName = [NSString stringWithFormat:@"uclist_%d",i];
                break;
            case 2:
                model.iconName = @"zuji";
                break;
            case 3:
                model.iconName = [NSString stringWithFormat:@"uclist_%d",i - 2];
                break;
                
            default:
                break;
        }
        
        [self.manageArr addObject:model];
    }
    
    [self setInfoArray];
}

- (void)initOtherData {
    
    //    NSArray *uArr = @[@"他的主题 ",@"他的回复"];
    NSArray *uArr = @[];
    for (int i = 0; i < uArr.count; i ++) {
        TextIconModel *model = [[TextIconModel alloc] init];
        model.text = uArr[i];
        model.iconName = [NSString stringWithFormat:@"ucex_%d",i];
        [self.useArr addObject:model];
    }
    
    NSArray *manageArr = @[@"用户组", @"管理组", @"注册时间"];
    
    for (int i = 0; i < manageArr.count; i ++) {
        TextIconModel *model = [[TextIconModel alloc] init];
        model.text = manageArr[i];
        model.iconName = [NSString stringWithFormat:@"uclist_%d",i];
        if (i == 1) {
            model.iconName = [NSString stringWithFormat:@"uclist_%d",i + 1];
        }
        if (i == 2) {
            model.iconName = [NSString stringWithFormat:@"uclist_%d",i - 1];
        }
        
        [self.manageArr addObject:model];
    }
    
    [self setInfoArray];
}

- (void)setInfoArray {
    NSArray *InfoArr = @[@"主题数", @"回帖数",@"积分"];
    for (int i = 0; i < InfoArr.count; i ++) {
        TextIconModel *model = [[TextIconModel alloc] init];
        model.text = InfoArr[i];
        model.iconName = [NSString stringWithFormat:@"ucex_%d",i];
        [self.infoArr addObject:model];
    }
}

-(void)setUserVarModel:(DZUserVarModel *)userVarModel{
    _userVarModel = userVarModel;
    for (int i = 0; i < self.manageArr.count; i ++) {
        TextIconModel *model = self.manageArr[i];
        if (_isOther) {
            switch (i) {
                case 0:
                {
                    model.detail = self.userVarModel.space.group.grouptitle;
                }
                    break;
                case 1:
                {
                    model.detail = self.userVarModel.space.admingroup.grouptitle;
                }
                    break;
                case 2:
                {
                    model.detail = self.userVarModel.space.regdate;
                }
                    break;
                    
                default:
                    break;
            }
        } else {
            switch (i) {
                case 0:
                {
                    model.detail = @"";
                }
                    break;
                case 1:
                {
                    model.detail = self.userVarModel.space.regdate;
                }
                    break;
                case 2:
                {
                    model.detail = @"";
                }
                    break;
                    
                default:
                    break;
            }
        }
    }
    for (int i = 0; i < self.infoArr.count; i ++) {
        TextIconModel *model = self.infoArr[i];
        switch (i) {
            case 0:
                model.detail = self.userVarModel.space.threads;
                break;
            case 1:
            {
                NSString *poststr = self.userVarModel.space.posts;
                NSString *threads = self.userVarModel.space.threads;
                NSInteger realPost = [poststr integerValue] - [threads integerValue];
                model.detail = [NSString stringWithFormat:@"%ld",realPost];
            }
                
                break;
            case 2:
                model.detail = self.userVarModel.space.credits;
                break;
            default:
                break;
        }
    }

    NSDictionary * extcreditsDict = self.userVarModel.extcredits;
    //从扩展积分设置中读取扩展积分的名称
    for (int index = 1; index <= extcreditsDict.allKeys.count; index++) {
        NSDictionary *dict = [extcreditsDict dictionaryForKey:[NSString stringWithFormat:@"%lu",self.infoArr.count + 1]];
        TextIconModel *itemModel = [[TextIconModel alloc] init];
        itemModel.text = [dict stringForKey:@"title"];
        if (index == 1){
            itemModel.detail = userVarModel.space.extcredits1;
        }else if (index == 2){
            itemModel.detail = userVarModel.space.extcredits2;
        }else if (index == 3){
            itemModel.detail = userVarModel.space.extcredits3;
        }else if (index == 4){
            itemModel.detail = userVarModel.space.extcredits4;
        }else if (index == 5){
            itemModel.detail = userVarModel.space.extcredits5;
        }else{
            itemModel.detail = nil;
        }
        itemModel.iconName = [NSString stringWithFormat:@"ucex_%d",index];
        if (itemModel.text.length) {
            [self.infoArr addObject:itemModel];
        }
    }
}


- (NSMutableArray<TextIconModel *> *)infoArr {
    if (!_infoArr) {
        _infoArr = [NSMutableArray array];
    }
    return _infoArr;
}

- (NSMutableArray<TextIconModel *> *)manageArr {
    if (!_manageArr) {
        _manageArr = [NSMutableArray array];
    }
    return _manageArr;
}

- (NSMutableArray<TextIconModel *> *)useArr {
    if (!_useArr) {
        _useArr = [NSMutableArray array];
    }
    return _useArr;
}

@end
