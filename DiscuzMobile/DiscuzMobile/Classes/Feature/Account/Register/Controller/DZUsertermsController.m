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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollview = [[UIScrollView alloc] initWithFrame:KView_OutNavi_Bounds];
    [self.view addSubview:self.scrollview];
    [self dz_bringNavigationBarToFront];
    [self.scrollview addSubview:self.contentLabel];
    self.scrollview.backgroundColor = [UIColor whiteColor];
    self.dz_NavigationItem.title = checkTwoStr(DZ_APPNAME, @"服务条款");
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    CGSize messageSize = [self.contentLabel.text sizeWithFont:KFont(14) maxSize:CGSizeMake(KScreenWidth - kMargin30, CGFLOAT_MAX)];
    self.contentLabel.frame = CGRectMake(kMargin15, kMargin15, messageSize.width, messageSize.height);
    self.scrollview.contentSize = CGSizeMake(KScreenWidth, CGRectGetMaxY(self.contentLabel.frame) + KTabbar_Height);
    DLog(@"");
}


-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = KFont(14);
        NSString *fileName = DZ_BBSRULE;
        NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"txt"];
        _contentLabel.text = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    }
    return _contentLabel;
}






@end






