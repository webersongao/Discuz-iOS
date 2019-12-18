//
//  DZUserTableView.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/18.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZUserTableView.h"
#import "CenterCell.h"
#import "LogoutCell.h"

@implementation DZUserTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame style:UITableViewStylePlain];
    if (self) {
        [self registerClass:[LogoutCell class] forCellReuseIdentifier:@"LogoutCell"];
        [self registerClass:[CenterCell class] forCellReuseIdentifier:@"CenterCell"];
    }
    return self;
}





@end










