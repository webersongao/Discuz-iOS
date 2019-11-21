//
//  DZForumCateListController.h
//  PandaReader
//
//  Created by WebersonGao on 2018/10/25.
//

#import "DZBaseViewController.h"
#import "DZForumListTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface DZForumCateListController : DZBaseViewController

@property (nonatomic,copy) NSString *column;
@property (nonatomic,copy) NSString *subtype;

- (instancetype)initWithFrame:(CGRect)frame;

-(void)loadChildsViewFirstDataFromServer;


@end

NS_ASSUME_NONNULL_END
