//
//  DZRefreshFooter.m
//  PandaReader
//
//  Created by WebersonGao on 2019/4/11.
//  Copyright © 2019 ZHWenXue. All rights reserved.
//

#import "DZRefreshFooter.h"

@implementation DZRefreshFooter
- (void)prepare
{
    [super prepare];
    
    NSMutableArray *imageArray = [NSMutableArray arrayWithCapacity:7];
    for (NSInteger index = 1; index <= 7; index++) {
        NSString *imageName = [NSString stringWithFormat:@"refreshheader_%ld",(long)index];
        UIImage *headerloadingImg = [UIImage imageNamed:imageName];
        if (headerloadingImg) {
            [imageArray addObject:headerloadingImg];        
        }
    }
    [self setImages:imageArray forState:MJRefreshStateIdle];
    [self setImages:imageArray forState:MJRefreshStatePulling];
    [self setImages:imageArray forState:MJRefreshStateRefreshing];
    
    self.stateLabel.hidden = YES;
}

- (void)placeSubviews
{
    [super placeSubviews];
    
    self.gifView.frame = self.bounds;
    self.gifView.contentMode = UIViewContentModeCenter;
}

@end
