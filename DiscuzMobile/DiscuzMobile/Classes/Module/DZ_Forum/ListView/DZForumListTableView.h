//
//  DZForumListTableView.h
//  PandaReader
//
//  Created by WebersonGao on 2018/10/22.
//

#import <UIKit/UIKit.h>
#import "DZVIPCategoryInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@class DZForumListTableView;

@protocol DZForumListTableDelegate <NSObject>

@optional
-(void)loadVIPCategoryTableViewMoreData:(DZForumListTableView *)VIPCategoryTableView;

@end

@interface DZForumListTableView : UITableView

@property (nonatomic,assign) NSInteger is_next;
@property (nonatomic,strong) NSArray *dataModelArray;
@property (nonatomic,assign) id<DZForumListTableDelegate> listDelegate;
    
@end

NS_ASSUME_NONNULL_END
