//
//  DZGaoThreadCell+Manager.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/23.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZGaoThreadCell+Manager.h"
#import "DZForumTool.h"

@implementation DZGaoThreadCell (Manager)


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configThreadCellManager];
    }
    return self;
}


-(void)configThreadCellManager{
    [self.IconButton addTarget:self action:@selector(IconButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.zanButton addTarget:self action:@selector(zanButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}

// 点击头像
-(void)IconButtonAction:(UIButton *)button{
    [[DZMobileCtrl sharedCtrl] PushToOtherUserController:self.cellModel.authorid];
}

// 点赞
-(void)zanButtonAction:(UIButton *)button{
    
    if (![DZLoginModule isLogged]) {
        DLog(@"WBS 用户未登录呦~~~");
        return;
    }
    
    if ([self.cellModel.recommend isEqualToString:@"1"]) {
        [MBProgressHUD showInfo:@"您已赞过该主题"];
    } else {
        button.enabled = NO;
        [DZForumTool DZ_PraiseRequestTid:self.cellModel.tid successBlock:^{
            if (self.cellModel.isRecently) {
                BACK(^{
                    if ([DataCheck isValidString:self.cellModel.tid]) {
                        [[DZDatabaseHandle Helper] footThread:self.cellModel];
                    }
                });
                [self resetPraise:YES];
            }
        } failureBlock:^(NSError *error){
            [self resetPraise:NO];
        }];
    }
}

- (void)resetPraise:(BOOL)isSuccess {
    
    self.zanButton.selected = isSuccess;
    self.cellModel.recommend = isSuccess ? @"1" : @"0";
    if (isSuccess) {
        self.cellModel.recommend_add = [NSString stringWithFormat:@"%ld",[self.cellModel.recommend_add integerValue] + 1];
    }else{
        self.zanButton.enabled = YES;
    }
    [self.zanButton setTitle:checkTwoStr(@"点赞：", self.cellModel.recommend_add) forState:UIControlStateNormal];
}





@end
