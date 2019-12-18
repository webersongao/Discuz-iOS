//
//  DZDiscoverListView.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/22.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZBaseTableView.h"
#import "DZDiscoverListCell.h"

@interface DZDiscoverListView : DZBaseTableView

- (instancetype)initWithListFrame:(CGRect)frame;

-(void)updateListView:(NSArray *)array;

@end


