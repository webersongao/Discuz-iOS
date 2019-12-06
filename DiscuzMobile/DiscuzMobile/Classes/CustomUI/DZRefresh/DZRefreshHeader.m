//
//  PRRefreshHeader.m
//  PandaReader
//
//  Created by changle on 2018/3/30.
//

#import "DZRefreshHeader.h"

@interface DZRefreshHeader ()

@end

@implementation DZRefreshHeader

#pragma mark 基本设置
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
    
    self.lastUpdatedTimeLabel.hidden = YES;
    self.automaticallyChangeAlpha = YES;
    self.stateLabel.hidden = YES;
}

- (void)placeSubviews
{
    [super placeSubviews];
    
    self.gifView.frame = self.bounds;
}


- (void)checkRestartLoadingAnimation
{
    if (self.state == MJRefreshStateRefreshing && !self.gifView.isAnimating) {
        [self.gifView startAnimating];
    }
}

@end
