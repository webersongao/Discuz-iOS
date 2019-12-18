//
//  DZUserDataModel.m
//  DiscuzMobile
//
//  Created by HB on 2017/9/8.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import "DZUserDataModel.h"
#import "TextIconModel.h"

@interface DZUserDataModel ()

@property (nonatomic, strong) NSArray *baseArray;  //!< 属性注释
@property (nonatomic, strong) NSArray *UserArray;  //!< 属性注释
@property (nonatomic, strong) NSArray *extcreditsArray;  //!< 属性注释
@property (nonatomic, strong) TextIconModel *endModel;  //!< 属性注释
@end

@implementation DZUserDataModel

- (instancetype)initWithType:(JTCenterType)type {
    self = [super init];
    if (self) {
        [self configUserData:type];
    }
    return self;
}

-(void)configUserData:(JTCenterType)type{
    
    self.baseArray = [self baseInitData];
    
    if (type == JTCenterTypeMy) {
        self.UserArray = [self myUserInitData];
        self.endModel = [TextIconModel initWithText:@"退出" andIconName:nil andDetail:nil];
    }else{
        self.UserArray = [self otherInitData];
        self.endModel = [TextIconModel initWithText:@"加好友" andIconName:nil andDetail:nil];
    }
    self.extcreditsArray = [self extcreditsArray];
    self.isOther = (type == JTCenterTypeOther) ? YES : NO;
    
}


-(NSArray *)baseInitData{
    TextIconModel *model01 = [TextIconModel initWithText:@"用户组" andIconName:@"uclist_0" andDetail:nil];
    TextIconModel *model02 = [TextIconModel initWithText:@"管理组" andIconName:@"uclist_2" andDetail:nil];
    TextIconModel *model03 = [TextIconModel initWithText:@"注册时间" andIconName:@"uclist_1" andDetail:nil];
    return @[model01,model02,model03];
}

- (NSArray *)myUserInitData {
    
    TextIconModel *other01 = [TextIconModel initWithText:@"我的主题" andIconName:@"ucex_0" andDetail:nil];
    TextIconModel *other02 = [TextIconModel initWithText:@"我的回复" andIconName:@"ucex_1" andDetail:nil];
    
    return @[other01,other02];
}

- (NSArray *)otherInitData {
    
    TextIconModel *other01 = [TextIconModel initWithText:@"他的主题" andIconName:@"ucex_0" andDetail:nil];
    TextIconModel *other02 = [TextIconModel initWithText:@"他的回复" andIconName:@"ucex_1" andDetail:nil];
    
    return @[other01,other02];
}

- (NSArray *)extcreditsArray {
    
    TextIconModel *ext01 = [TextIconModel initWithText:@"主题数" andIconName:@"ucex_0" andDetail:nil];  // 威望
    TextIconModel *ext02 = [TextIconModel initWithText:@"回帖数" andIconName:@"ucex_1" andDetail:nil];  // 金钱
    TextIconModel *ext03 = [TextIconModel initWithText:@"积分值" andIconName:@"ucex_2" andDetail:nil];  // 贡献
    
    return @[ext01,ext02,ext03];
}


-(NSArray *)userDataArray{
    
    if (self.baseArray && self.userDataArray && self.extcreditsArray) {
        return @[self.baseArray,self.userDataArray,self.extcreditsArray,@[self.endModel]];
    }else{
        return nil;
    }
}




-(void)setUserVarModel:(DZUserVarModel *)userVarModel{
    _userVarModel = userVarModel;
    
    // 基本信息
    for (int i = 0; i < self.baseArray.count; i ++) {
        TextIconModel *model = self.baseArray[i];
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
    }
    
    // 主题数 回帖 积分
    for (int i = 0; i < self.extcreditsArray.count; i ++) {
        TextIconModel *model = self.extcreditsArray[i];
        switch (i) {
            case 0:
                model.detail = self.userVarModel.space.threads;
                break;
            case 1:
            {
                NSString *poststr = self.userVarModel.space.posts;
                NSString *threads = self.userVarModel.space.threads;
                NSInteger realPost = [poststr integerValue] - [threads integerValue];
                model.detail = [NSString stringWithFormat:@"%ld",(long)realPost];
            }
                break;
            case 2:
                model.detail = self.userVarModel.space.credits;
                break;
            default:
                break;
        }
    }
    
    //从扩展积分设置中读取扩展积分的名称
    
    NSDictionary * extcreditsDict = userVarModel.extcredits;
    for (int index = 1; index <= extcreditsDict.allKeys.count; index++) {
        
        NSDictionary *rootDict = [extcreditsDict dictionaryForKey:checkInteger(index)];
        NSString *titleStr = [rootDict stringForKey:@"title"];
        
        NSString *detailStr = nil;
        if (index == 1){
            detailStr = userVarModel.space.extcredits1;
        }else if (index == 2){
            detailStr = userVarModel.space.extcredits2;
        }else if (index == 3){
            detailStr = userVarModel.space.extcredits3;
        }else if (index == 4){
            detailStr = userVarModel.space.extcredits4;
        }else if (index == 5){
            detailStr = userVarModel.space.extcredits5;
        }else{
            detailStr = nil;
        }
        NSString * imageStr  = [NSString stringWithFormat:@"ucex_%ld",(long)index];
        
        if (titleStr.length) {
            TextIconModel *itemModel = [TextIconModel initWithText:titleStr andIconName:imageStr andDetail:detailStr];
//            [self.infoArr addObject:itemModel];
        }
    }
    
//    self.extcreditsArray = [[]]
}



//- (void)initData {
//
//    TextIconModel *model01 = [TextIconModel initWithText:@"注册时间" andIconName:@"uclist_1" andDetail:nil];
//    TextIconModel *model02 = [TextIconModel initWithText:@"我的足迹" andIconName:@"zuji" andDetail:nil];
//    TextIconModel *model03 = [TextIconModel initWithText:@"绑定管理" andIconName:@"bind_icon" andDetail:nil];
//    TextIconModel *model04 = [TextIconModel initWithText:@"修改密码" andIconName:@"uclist_2" andDetail:nil];
//
//    [self.manageArr addObjectsFromArray:@[model01,model02,model03,model04]];
//}

@end
