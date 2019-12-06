//
//  DZNavItemButton.h
//  PandaReader
//
//  Created by WebersonGao on 2019/4/4.
//  Copyright © 2019 ZHWenXue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DZNavItemButton : UIButton

/** 左边item还是右边item */
@property(nonatomic,assign) BOOL isLeft;
@property(nonatomic,assign) BOOL isBack;


@end

NS_ASSUME_NONNULL_END
