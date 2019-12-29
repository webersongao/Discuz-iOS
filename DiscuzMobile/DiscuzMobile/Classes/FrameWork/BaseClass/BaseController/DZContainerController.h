//
//  TTContainerController.h
//  DiscuzMobile
//
//  Created by ZhangJitao on 16/4/23.
//  Copyright © 2016年 comsenz-service.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DZSegmentedControl.h"

@interface DZContainerController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, assign) BOOL sendNotify;
@property (nonatomic,strong) UIColor *naviBackgroundColor;

@property (nonatomic, weak) UIViewController *parentController;
@property (strong, nonatomic) DZSegmentedControl *segmentControl;
@property (nonatomic,strong) UICollectionViewFlowLayout *flowLayout;
@property (strong, nonatomic) UITableViewController *currentController;
@property (strong, nonatomic) NSArray <UITableViewController *>*viewControllers;

- (void)configSubControllers:(NSArray<UITableViewController *>*)subControllers parentVC:(UIViewController *)parentVC segmentRect:(CGRect)segmentRect;

@end
