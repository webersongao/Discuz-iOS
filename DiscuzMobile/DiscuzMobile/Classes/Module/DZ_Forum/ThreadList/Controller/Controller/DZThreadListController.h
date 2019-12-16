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

@interface DZThreadListController : DZForumListBaseCtrl

@property (nonatomic, copy) SendValueBlock dataBlockWhenAll; // 当且仅在 listType 为all的时候返才会调用返回数据
@property (nonatomic, copy) backNoneBlock endRefreshBlock;

- (void)refreshThreadListData;

- (instancetype)initWithType:(DZ_ListType)listType fid:(NSString *)fid order:(NSInteger)order;


@end



