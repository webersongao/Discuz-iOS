//
//  PRTriangleCaptionBtn.h
//  PandaReaderApp
//
//  Created by WebersonGao on 2019/6/4.
//

#import <UIKit/UIKit.h>

@interface PRTriangleCaptionBtn : UIView

- (void)setTitleAlignment:(NSTextAlignment)alignment;
- (void)setBottomBtnTitleColor;
- (void)updateCaptionState:(BOOL)bSelected;
- (void)setCaptionTitleTopFont:(UIFont *)font;
- (void)setCaptionTitleColor:(UIColor *)color forState:(UIControlState)State;
- (void)setCaptionBtnTitleColor:(UIColor *)color forSelectState:(BOOL)bSelectState;
- (void)addCaptionTitleTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;
- (void)setCaptionTitleInfo:(NSString*)normalTitle bottom:(NSString*)bottom image:(NSString *)imagUrl highImgUrl:(NSString *)highImgUrl buttonKey:(NSString *)key;

@end

