//
//  ParInActiveModel.m
//  DiscuzMobile
//
//  Created by HB on 2017/8/4.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import "ParInActiveModel.h"

@implementation ParInActiveModel

-(void)setChoices:(NSString *)choices{
    _choices = choices;
    _choicesArray = [choices componentsSeparatedByString:@"\n"];
}

@end
