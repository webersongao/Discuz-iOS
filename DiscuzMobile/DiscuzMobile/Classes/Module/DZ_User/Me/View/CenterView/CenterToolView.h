//
//  CenterToolView.h
//  DiscuzMobile
//
//  Created by HB on 17/1/19.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DZVerticalButton.h"
@class TextIconModel;

typedef void(^ToolItemClickBlock)(DZVerticalButton *sender, NSInteger index, NSString *name);

@interface CenterToolView : UIView

@property (nonatomic, strong) NSMutableArray<TextIconModel *> *iconTextArr;

@property (nonatomic, copy) ToolItemClickBlock toolItemClickBlock;

@end
