//
//  DZGlobalModel.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/15.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZGlobalModel.h"

@implementation DZGlobalModel

-(void)setCookiepre:(NSString *)cookiepre{
    _cookiepre = cookiepre;
    _authKey = [NSString stringWithFormat:@"%@%@",cookiepre,@"auth"];
}

-(BOOL)isUserLogin{
    if (self.member_uid.length && ![self.member_uid isEqualToString:@"0"] && self.member_username.length) {
        return YES;
    }
    return NO;
}
#pragma mark   /********************* 数据库继承方法 *************************/

- (NSArray *)primaryKey
{
    NSString *uidStr = checkNull(self.member_uid);
    return @[FieldName(uidStr)];
}

- (NSString *)tableName
{
    return @"DZGlobalTable";
}

- (void)startUpdateProperties
{
    NSArray *updateProperties = @[@"member_uid",@"member_username",@"formhash"];
    [super startUpdateProperties:updateProperties];
}

-(NSArray *)excludedFields
{
    return @[@"rowID"];
}

@end



