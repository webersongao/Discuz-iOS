//
//  DZWebBrowerHelper.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2020/1/3.
//  Copyright © 2020 comsenz-service.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DZWebBrowerHelper : NSObject

+ (instancetype)sharedHelper;

- (void)showPhotoImageSources:(NSArray *)imagesArray thumImages:(NSArray *)thumArray currentIndex:(NSInteger)index imageContainView:(UIView *)imageContainer;

@end

