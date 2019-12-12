//
//  DZSearchNetTool.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/12.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZSearchNetTool.h"

@implementation DZSearchNetTool


// 搜索
+(void)DZ_SearchForumWithKey:(NSString *)keyWord Page:(NSInteger)Page completion:(void(^)(DZSearchVarModel *varModel,NSError *error))completion{
    
    if (!keyWord.length || !completion) {
        return;
    }
    
    NSDictionary *dict = @{@"srchtxt":keyWord,
                           @"page":checkInteger(Page)};
    [DZApiRequest requestWithConfig:^(JTURLRequest *request) {
        request.urlString = DZ_Url_Search;
        request.parameters = dict;
    } success:^(id responseObject, JTLoadType type) {
        
        NSDictionary *dict = [responseObject dictionaryForKey:@"Variables"];
        DZSearchVarModel *varModel =[DZSearchVarModel modelWithJSON:dict];
        
        for (DZSearchModel *model in varModel.threadlist) {
            model.keyword = keyWord;
        }
        completion(varModel,nil);
        
    } failed:^(NSError *error) {
        completion(nil,error);
    }];
}





@end
