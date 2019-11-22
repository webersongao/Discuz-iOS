//
//  DZForumCateListController.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/22.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZForumCateListController.h"
#import "DZBaseForumModel.h"
#import "DZForumListView.h"

@interface DZForumCateListController ()

@property (nonatomic, strong) DZForumListView *listView;  //!< 属性注释

@end

@implementation DZForumCateListController

- (instancetype)initWithFrame:(CGRect)frame Model:(DZBaseForumModel *)model
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



@end
