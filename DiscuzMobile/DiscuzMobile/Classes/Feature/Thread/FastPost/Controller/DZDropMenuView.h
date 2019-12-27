//
//  DZDropMenuView.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/27.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DZDropMenuView;
@protocol DZDropMenuViewDelegate <NSObject>

-(void)DZDropMenuView:(DZDropMenuView *)view didSelectName:(NSString *)String;

@end



@interface DZDropMenuView : UIView

@property (nonatomic, weak) id<DZDropMenuViewDelegate> delegate;

/** 箭头变化 */
@property (nonatomic, strong) UIView *arrowView;


/**
  控件设置

 @param view 提供控件 位置信息
 @param tableNum 显示TableView数量
 @param arr 使用数据
 */
-(void)creatDropView:(UIView *)view withShowTableNum:(NSInteger)tableNum withData:(NSArray *)arr;

/** 视图消失 */
- (void)dismiss;


@end
