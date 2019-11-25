//
//  DZDiscoverCateController.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/22.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZDiscoverCateController.h"
#import "DZBaseForumModel.h"
#import "DZDiscoverListView.h"

@interface DZDiscoverCateController ()

@property (nonatomic, strong) DZDiscoverListView *listView;  //!< 属性注释

@end

@implementation DZDiscoverCateController

- (instancetype)initWithFrame:(CGRect)frame Model:(DZBaseForumModel *)model
{
    self = [super init];
    if (self) {
        self.listView = [[DZDiscoverListView alloc] initWithListFrame:frame];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}





@end
