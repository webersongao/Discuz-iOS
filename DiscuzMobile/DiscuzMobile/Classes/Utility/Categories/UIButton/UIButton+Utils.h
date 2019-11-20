//
//  UIButton+Utils.h
//  DiscuzMobile
//
//  Created by WebersonGao on 15/11/6.
//
//

#import <UIKit/UIKit.h>
#import "UIButton+ImageTitleSpacing.h"

@interface UIButton (Utils)

/// 设置按钮的三个状态图片
- (void)setNormalImage:(NSString *)normalImage HighlightedImage:(NSString *)highlightedImage selectedImage:(NSString *)selectedImage;

//// 创建一个纯文字按钮
+(UIButton *)ButtonTextWithFrame:(CGRect)frame titleStr:(NSString *)titleStr titleColor:(UIColor *)titleColor titleTouColor:(UIColor *)titleTouColor font:(UIFont *)font Radius:(CGFloat)Radius Target:(id)target action:(SEL)btnAction;

/// 创建按钮
+ (UIButton *)ButtonNormalWithFrame:(CGRect)frame title:(NSString *)title titleFont:(UIFont *)titleFont titleColor:(UIColor *)titleColor normalImgPath:(NSString *)normalPath touchImgPath:(NSString*)touchUpPath isBackImage:(BOOL)isBackImage;


@end
