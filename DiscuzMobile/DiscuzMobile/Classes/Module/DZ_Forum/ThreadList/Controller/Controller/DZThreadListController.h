//
//  DZThreadListController.h
//  DiscuzMobile
//
//  Created by HB on 2017/5/19.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import "DZForumListBaseCtrl.h"
#import "DZThreadVarModel.h"
#import "DZThreadNetTool.h"

typedef void(^SendValueBlock)(DZThreadVarModel *varModel);
typedef void(^EndRefreshBlock)(void);

@interface DZThreadListController : DZForumListBaseCtrl

@property (nonatomic, copy) NSString *fid;
@property (nonatomic, assign) NSInteger order;

@property (nonatomic, copy) SendValueBlock sendListBlock;
@property (nonatomic, copy) EndRefreshBlock endRefreshBlock;

- (void)refreshData;

- (instancetype)initWithType:(DZ_ListType)listType;


@end



