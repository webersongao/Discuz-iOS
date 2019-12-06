//
//  PartInMultiSelectCell.h
//  DiscuzMobile
//
//  Created by HB on 2017/8/11.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import "DZBaseTableViewCell.h"

typedef void(^SendUserArrayBlock)(NSArray *userArray);

@interface PartInMultiSelectCell : DZBaseTableViewCell

@property (nonatomic, strong) NSMutableArray *userArray;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) NSMutableArray *multiSelectArray;

@property (nonatomic, copy) SendUserArrayBlock senduserBlock;

- (CGFloat)cellHeight;

@end
