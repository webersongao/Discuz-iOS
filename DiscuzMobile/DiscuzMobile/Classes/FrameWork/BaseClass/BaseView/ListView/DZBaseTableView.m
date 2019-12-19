//
//  DZBaseTableView.m
//  PandaReader
//
//  Created by 孙震 on 2019/5/13.
//  Copyright © 2019 ZHWenXue. All rights reserved.
//

#import "DZBaseTableView.h"

@implementation DZBaseTableView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self loadSetting];
        self.backgroundColor = KRandom_Color;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

- (void)loadSetting {
    self.estimatedRowHeight = 0;
    self.estimatedSectionHeaderHeight = 0;
    self.estimatedSectionFooterHeight = 0;
    self.separatorColor = KColor(@"#ECECEC", 1);
    if (@available(iOS 11.0, *)) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}

@end
