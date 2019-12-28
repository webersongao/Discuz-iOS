//
//  DZMenuTableListView.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/27.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DZMenuTableListView;
@protocol DZMenuTableViewDelagete <NSObject>

-(void)MenuTableView:(DZMenuTableListView *)view didSelectCell:(DZForumBaseNode *)cellNode;

@end

@interface DZMenuTableListView : UIView

@property (nonatomic, strong) NSArray *nodeDataArray;
@property (nonatomic, weak) id<DZMenuTableViewDelagete> delegate;

-(void)dismissMenuListView;

@end
