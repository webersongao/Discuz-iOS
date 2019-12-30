//
//  WebLogicManager.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/29.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "WebLogicManager.h"


@interface WebLogicManager ()

@property (nonatomic,strong) NSDictionary *paramsDictionary;

@end

@implementation WebLogicManager

+(WebLogicManager *)sharedManager
{
    static WebLogicManager *clientInformation = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        clientInformation = [[WebLogicManager alloc] init];
    });
    return clientInformation;
}

-(void)webLogicNativeCallData:(NSDictionary *)data
{
    NSDictionary* params = [data objectForKey:@"params"];
    NSString *appFunc = [params stringForKey:@"appFunc"];
    NSDictionary *dataDic = [params dictionaryForKey:@"data"];
    NSString *handleIdStr= [params stringForKey:@"handleId"];
    
    self.paramsDictionary = dataDic;
    
}

-(void)webLogicJumpToViewData:(NSDictionary *)data
{
    NSDictionary* params = [data objectForKey:@"params"];
    NSDictionary *dataDic = [params dictionaryForKey:@"data"];
    NSString *screen = [params stringForKey:@"screen"];
    self.paramsDictionary = dataDic;
    
}

#pragma mark - get web dataDic
- (NSDictionary *)webDataDictionary
{
    return self.paramsDictionary;
}


@end
