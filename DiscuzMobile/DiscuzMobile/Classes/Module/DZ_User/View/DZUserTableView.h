//
//  DZUserTableView.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/18.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZBaseTableView.h"
#import "DZUserDataModel.h"

@interface DZUserTableView : DZBaseTableView

@property (nonatomic, copy) void(^CellTapAction)(TextIconModel *cellModel) ;  //!< 属性注释

-(void)updateUserTableView:(DZUserDataModel *)Model;



@end


