//
//  DZApplyProperty.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/10.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DZApartInItem : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *value;

- (instancetype)initWithTitle:(NSString *)title Value:(NSString *)value;
@end


