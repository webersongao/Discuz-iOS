//
//  DZAreaViewController.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/29.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZAreaViewController.h"
#import "DZForumController.h"
#import "DZDiscoverController.h"


@interface DZAreaViewController ()

@property(nonatomic,strong)DZForumController *forumVC;
@property(nonatomic,strong)DZDiscoverController *discoverVC;


@end

@implementation DZAreaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.forumVC = [[DZForumController alloc] init];
    self.discoverVC = [[DZDiscoverController alloc] init];
    
    [self addChildViewController:self.forumVC];
    [self addChildViewController:self.discoverVC];
}







@end
