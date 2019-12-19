//
//  DZThreadAttach.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/19.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZThreadAttach.h"

@interface DZThreadAttach ()

@property (nonatomic, strong) UIImageView *imageOne;  //!< 属性注释
@property (nonatomic, strong) UIImageView *imageTwo;  //!< 属性注释
@property (nonatomic, strong) UIImageView *imageThree;  //!< 属性注释

@end

@implementation DZThreadAttach

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.imageOne = [[UIImageView alloc] initWithFrame:CGRectMake(kMargin10, kMargin10, 0, 0)];
        self.imageTwo = [[UIImageView alloc] initWithFrame:CGRectMake(kMargin10, kMargin10, 0, 0)];
        self.imageThree = [[UIImageView alloc] initWithFrame:CGRectMake(kMargin10, kMargin10, 0, 0)];
    }
    return self;
}



-(void)updateUrlList:(NSArray *)UrlArray size:(CGSize)viewSize{
    
    if (UrlArray.count > 0) {
        [self.imageOne sd_setImageWithURL:[NSURL URLWithString:UrlArray[0]]];
    }
    
}







@end
