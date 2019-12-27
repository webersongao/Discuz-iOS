//
//  DZGaoPostViewController.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/27.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZGaoPostViewController.h"
#import "DZMenuTableListView.h"

@interface DZGaoPostViewController ()

@property (nonatomic, strong) DZMenuTableListView *menuBar;  //条件选择器

@end

@implementation DZGaoPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configPostViewController];
}

-(void)configPostViewController{
    self.menuBar = [[DZMenuTableListView alloc] initWithFrame:CGRectMake(0, KNavi_ContainStatusBar_Height, KScreenWidth, kToolBarHeight)];
    [self.view addSubview:self.menuBar];
    self.menuBar.backgroundColor = [UIColor whiteColor];
}

-(void)leftBarBtnClick{
    [self.menuBar dismissMenuListView];
    [super leftBarBtnClick];
}

@end
