//
//  DZLocalContext.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/15.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZLocalContext.h"
#import "DZLocalDataHelper.h"

#define kDZUserTable @"PRDouMao.db"

static DZLocalContext *infoContext;

@implementation DZLocalContext

+ (DZLocalContext *)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        infoContext = [[DZLocalContext alloc] init];
    });
    return infoContext;
}

- (id)init{
    self = [super init];
    if (self) {
        _helper = [DZLocalDataHelper sharedHelper];
    }
    return self;
}

-(BOOL)removeLocalUser{
    __block BOOL result = YES;
    [_helper inTransaction:^(FMDatabase *database, BOOL *rollback) {
        result = [database executeUpdate:[NSString stringWithFormat:@"DELETE FROM %@", kDZUserTable]];
        *rollback = !result;
    }];
    return result;
}

- (BOOL)updateLocalUser:(DZUserModel *)user {
    return [self updateObject:user];
}

-(DZUserModel *)GetLocalUserInfo{
    __block NSMutableArray *userArr = [NSMutableArray array];
    [_helper inTransaction:^(FMDatabase *database, BOOL *rollback) {
        FMResultSet *resultSet = [database executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ order by rowID desc",kDZUserTable]];
        while ([resultSet next]) {
            NSDictionary *dict = [resultSet resultDictionary];
            DZUserModel *  user = [DZUserModel modelWithJSON:dict];
            [userArr addObject:user];
        }
        [resultSet close];
    }];
    DZUserModel *user = userArr.firstObject;
    if (user.auth.length && user.member_username.length) {
        return user;
    }else{
        return nil;
    }
}



#pragma mark   /********************* 工具方法 *************************/



@end
