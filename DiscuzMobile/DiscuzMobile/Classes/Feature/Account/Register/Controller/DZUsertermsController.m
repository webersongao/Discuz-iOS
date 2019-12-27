//
//  DZUsertermsController.m
//  DiscuzMobile
//
//  Created by HB on 17/3/8.
//  Copyright © 2017年 comsenz-service.com. All rights reserved.
//

#import "DZUsertermsController.h"

@interface DZUsertermsController ()

@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIScrollView *scrollview;

@end

@implementation DZUsertermsController

- (void)loadView {
    [super loadView];
    self.scrollview = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.scrollview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dz_NavigationItem.title = [NSString stringWithFormat:@"%@ 服务条款",DZ_APPNAME];
    
    self.contentLabel = [[UILabel alloc] init];
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.font = [DZFontSize HomecellNameFontSize16];
    [self.view addSubview:self.contentLabel];
//    bbsrule_discuz
    NSString *fileName = DZ_BBSRULE;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"txt"];
    self.contentLabel.text = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    CGSize messageSize = [self.contentLabel.text sizeWithFont:[DZFontSize HomecellNameFontSize16] maxSize:CGSizeMake(KScreenWidth - 40, CGFLOAT_MAX)];
    self.contentLabel.frame = CGRectMake(20, 15, messageSize.width, messageSize.height);
    self.scrollview.contentSize = CGSizeMake(KScreenWidth, CGRectGetMaxY(self.contentLabel.frame) + 40);
}


@end
