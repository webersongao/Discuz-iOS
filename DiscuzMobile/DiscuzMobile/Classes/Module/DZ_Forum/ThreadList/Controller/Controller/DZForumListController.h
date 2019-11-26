//
//  DZForumListController.h
//  DiscuzMobile
//
//  Created by HB on 2017/5/19.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import "DZForumListBaseCtrl.h"

typedef void(^SendValueBlock)(NSDictionary *dic);
typedef void(^EndRefreshBlock)(void);

typedef enum : NSUInteger {
    DZ_ListAll = 0, // 全部
    DZ_ListNew, // 最新
    DZ_ListHot, // 热门
    DZ_ListBest, // 精华
    DZ_ListPoll, // 投票
    DZ_ListHotThread, // 热帖
} DZ_ListType;

@interface DZForumListController : DZForumListBaseCtrl

@property (nonatomic, copy) NSString *fid;
@property (nonatomic, assign) NSInteger order;

@property (nonatomic, copy) SendValueBlock sendBlock;
@property (nonatomic, copy) EndRefreshBlock endRefreshBlock;

- (void)refreshData;

- (instancetype)initWithType:(DZ_ListType)listType;


@end



