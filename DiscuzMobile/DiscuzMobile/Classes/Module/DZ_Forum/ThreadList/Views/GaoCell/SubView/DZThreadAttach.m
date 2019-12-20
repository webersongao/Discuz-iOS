//
//  DZThreadAttach.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/19.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZThreadAttach.h"

@interface DZThreadAttach ()

@property (nonatomic, strong) UIImageView *line;  //!< 属性注释
@property (nonatomic, strong) UIImageView *imageOne;  //!< 属性注释
@property (nonatomic, strong) UIImageView *imageTwo;  //!< 属性注释
@property (nonatomic, strong) UIImageView *imageThree;  //!< 属性注释

@end

@implementation DZThreadAttach

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)cofigThreadAttach{
    
    self.line = [[UIImageView alloc] init];
    self.imageOne = [[UIImageView alloc] init];
    self.imageTwo = [[UIImageView alloc] init];
    self.imageThree = [[UIImageView alloc] init];
    
    [self addSubview:self.line];
    [self addSubview:self.imageOne];
    [self addSubview:self.imageTwo];
    [self addSubview:self.imageThree];
    
    self.imageOne.layer.cornerRadius = 2;
    self.imageOne.layer.masksToBounds = YES;
    
    self.imageTwo.layer.cornerRadius = 2;
    self.imageTwo.layer.masksToBounds = YES;
    
    self.imageThree.layer.cornerRadius = 2;
    self.imageThree.layer.masksToBounds = YES;
}


-(void)updateUrlList:(NSArray *)UrlArray size:(CGSize)viewSize{
    
    [self layoutAttachSubviews:viewSize];
    
    if (UrlArray.count > 0) {
        [self.imageOne sd_setImageWithURL:[NSURL URLWithString:UrlArray[0]]];
    }else{
        self.imageOne.image = nil;
    }
    
    if (UrlArray.count > 1) {
        [self.imageTwo sd_setImageWithURL:[NSURL URLWithString:UrlArray[1]]];
    }else{
        self.imageTwo.image = nil;
    }
    
    if (UrlArray.count > 2) {
        [self.imageThree sd_setImageWithURL:[NSURL URLWithString:UrlArray[2]]];
    }else{
        self.imageThree = nil;
    }
}


-(void)layoutAttachSubviews:(CGSize)viewSize{
    
    CGFloat cellWidth = (viewSize.width - kMargin10 *4)/3.f;
    
    self.line = [[UIImageView alloc] initWithFrame:CGRectMake(kMargin10, kMargin10, viewSize.width-kMargin20, 0.5)];
    
    self.imageOne.frame = CGRectMake(kMargin10, self.line.bottom + 5, cellWidth, viewSize.height-self.line.top);
    self.imageTwo.frame = CGRectMake(self.imageOne.right + kMargin10, self.line.bottom + 5, cellWidth, viewSize.height-self.line.top);
    self.imageThree.frame = CGRectMake(self.imageTwo.right + kMargin10, self.line.bottom + 5, cellWidth, viewSize.height-self.line.top);
    
}






@end
