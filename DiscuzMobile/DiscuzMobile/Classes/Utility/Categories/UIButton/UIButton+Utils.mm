//
//  UIButton+Utils.m
//  DiscuzMobile
//
//  Created by WebersonGao on 15/11/6.
//
//

#import "UIButton+Utils.h"


@implementation UIButton (Utils)

///  创建一个文字按钮 (文字居中)
+(UIButton *)ButtonTextWithFrame:(CGRect)frame titleStr:(NSString *)titleStr titleColor:(UIColor *)titleColor titleTouColor:(UIColor *)titleTouColor font:(UIFont *)font Radius:(CGFloat)Radius Target:(id)target action:(SEL)btnAction{
    
    UIButton *tmpButton = [[UIButton alloc]initWithFrame:frame];
    tmpButton.backgroundColor = [UIColor clearColor];
    if (titleStr.length) {
        [tmpButton setTitle:titleStr forState: UIControlStateNormal];
    }
    if (font) {
        tmpButton.titleLabel.font = font;
    }
    if (Radius > 0) {
        tmpButton.layer.cornerRadius = Radius;
        [tmpButton.layer masksToBounds];
    }
    [tmpButton setTitleColor:titleColor forState:UIControlStateNormal];
    [tmpButton setTitleColor:titleTouColor forState:UIControlStateHighlighted];
    if (target && btnAction) {
        [tmpButton addTarget:target action:btnAction forControlEvents:UIControlEventTouchUpInside];
    }
    tmpButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    return tmpButton;
}



- (void)setNormalImage:(NSString *)normalImage HighlightedImage:(NSString *)highlightedImage selectedImage:(NSString *)selectedImage{
    
    [self setImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:highlightedImage]  forState:UIControlStateHighlighted];
    [self setImage:[UIImage imageNamed:selectedImage]  forState:UIControlStateSelected];
}

/// 创建按钮
+ (UIButton *)ButtonNormalWithFrame:(CGRect)frame title:(NSString *)title titleFont:(UIFont *)titleFont titleColor:(UIColor *)titleColor normalImgPath:(NSString *)normalPath touchImgPath:(NSString*)touchUpPath isBackImage:(BOOL)isBackImage
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.backgroundColor = [UIColor clearColor];
    
    [button setTitle:title forState:UIControlStateNormal];
    
    if (titleFont) {
        button.titleLabel.font = titleFont;
    }
    if (titleColor) {
        [button setTitleColor:titleColor forState:UIControlStateNormal];
        [button setTitleColor:titleColor forState:UIControlStateSelected];
    }
    
    if (nil != normalPath) {
        UIImage *normalImage = [UIImage imageNamed:normalPath];
        if (isBackImage) {
            [button setBackgroundImage:normalImage forState:UIControlStateNormal];
        } else {
            [button setImage:normalImage forState:UIControlStateNormal];
        }
        
    }
    
    if (nil != touchUpPath) {
        UIImage *touchUpImage = [UIImage imageNamed:touchUpPath];
        if (isBackImage) {
            [button setBackgroundImage:touchUpImage forState:UIControlStateHighlighted];
            [button setBackgroundImage:touchUpImage forState:UIControlStateSelected];
        } else {
            [button setImage:touchUpImage forState:UIControlStateHighlighted];
            [button setImage:touchUpImage forState:UIControlStateSelected];
        }
    }
    return button;
}

@end

















