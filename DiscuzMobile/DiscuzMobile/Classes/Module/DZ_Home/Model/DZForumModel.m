//
//  DZForumModel.m
//  DiscuzMobile
//
//  Created by HB on 16/12/21.
//  Copyright © 2016年 comsenz-service.com.  All rights reserved.
//

#import "DZForumModel.h"

@implementation DZForumModel

-(void)setLastpost:(id)lastpost{
    if ([DataCheck isValidDictionary:lastpost]) {
        _lastpost = [[lastpost stringForKey:@"dateline"] transformationStr];
    } else {
        _lastpost = checkNull(lastpost);
    }
}



@end
