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

@property (nonatomic,strong) UIColor *navigotionBarBackgroundColor;
@property (nonatomic, assign) BOOL sendNotify;

@property (nonatomic, weak) UIViewController *parentController;
@property (strong, nonatomic) NSArray <UITableViewController *>*viewControllers;
@property (strong, nonatomic) UITableViewController *currentController;
@property (nonatomic,weak) UICollectionView *collectonView;
@property (nonatomic,weak) UICollectionViewFlowLayout *flowLayout;
@property (strong, nonatomic) DZSegmentedControl *segmentedControl;

- (void)setSubControllers:(NSArray<UITableViewController *>*)viewControllers parentController:(UIViewController *)vc andSegmentRect:(CGRect)segmentRect;

@end
