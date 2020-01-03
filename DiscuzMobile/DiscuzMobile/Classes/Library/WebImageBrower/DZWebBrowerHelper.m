//
//  DZWebBrowerHelper.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2020/1/3.
//  Copyright © 2020 comsenz-service.com. All rights reserved.
//

#import "DZWebBrowerHelper.h"
#import "SDPhotoBrowser.h"

@interface DZWebBrowerHelper()<SDPhotoBrowserDelegate>

@property (nonatomic, strong) NSArray *imagesArray;
@property (nonatomic, strong) NSArray *thumbArray;
@end

@implementation DZWebBrowerHelper

+ (instancetype)sharedHelper {
    static DZWebBrowerHelper *helper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[DZWebBrowerHelper alloc] init];
    });
    return helper;
}

- (void)showPhotoImageSources:(NSArray *)imagesArray thumImages:(NSArray *)thumArray currentIndex:(NSInteger)index imageContainView:(UIView *)imageContainer {
    SDPhotoBrowser *photoBrowser = [SDPhotoBrowser new];
    photoBrowser.delegate = self;
    self.imagesArray = imagesArray.mutableCopy;
    self.thumbArray = thumArray.mutableCopy;
    photoBrowser.currentImageIndex = index;
    photoBrowser.imageCount = self.imagesArray.count;
    photoBrowser.sourceImagesContainer = imageContainer;
    [photoBrowser show];
}

#pragma mark - 图片查看器delegate
// 返回临时占位图片（即原来的小图）
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index {
    UIImageView *imageView = [[UIImageView alloc] init];
    if ([self.thumbArray[index] isKindOfClass:[UIImage class]]) {
        imageView.image = self.thumbArray[index];
    } else {
        NSString *urlStr = self.thumbArray[index];
        [imageView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"wutu"] options:SDWebImageRetryFailed];
    }
    return imageView.image;
}

// 返回高质量图片的url
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index {
    if ([self.imagesArray[index] isKindOfClass:[UIImage class]]) {
        return nil;
    }
    NSString *urlStr = self.imagesArray[index];
    return [NSURL URLWithString:urlStr];
}


@end


