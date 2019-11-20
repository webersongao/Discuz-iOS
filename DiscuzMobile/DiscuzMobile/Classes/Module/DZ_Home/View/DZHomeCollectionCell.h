//
//  DZHomeCollectionCell.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/20.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DZForumInfoModel.h"

@interface DZHomeCollectionCell : UICollectionViewCell

@property (nonatomic, strong, readonly) DZForumInfoModel *cellModel;  //!< <#属性注释#>

-(void)updateForumCellWithModel:(DZForumInfoModel *)cellModel;

@end


