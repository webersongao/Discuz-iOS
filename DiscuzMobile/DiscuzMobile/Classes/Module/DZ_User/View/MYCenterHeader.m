//
//  MYCenterHeader.m
//  DiscuzMobile
//
//  Created by HB on 17/1/19.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import "MYCenterHeader.h"
#import "CenterToolView.h"

@implementation MYCenterHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initCommit];
    }
    return self;
}

- (void)initCommit {
    self.userInfoView = [[CenterUserInfoView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 135)];
    [self addSubview:self.userInfoView];
    
    self.userInfoView.nameLab.text = @"---";
    
    self.tooView = [[CenterToolView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.userInfoView.frame) + 5, KScreenWidth, 85)];
    [self addSubview:self.tooView];
}


-(void)updateHeader:(NSString *)name title:(NSString *)title icon:(NSString *)iconName{
    [self.userInfoView updateInfoHeader:name title:title icon:iconName];
}




@end
