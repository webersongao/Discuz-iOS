//
//  DZHomeCollectionCell.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/20.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZBaseCollectionCell.h"
#import "DZForumModel.h"

@interface DZHomeCollectionCell : DZBaseCollectionCell

@property (nonatomic, strong, readonly) DZForumModel *cellModel;  //!< <#属性注释#>

-(void)updateForumCellWithModel:(DZForumModel *)cellModel;

@end


