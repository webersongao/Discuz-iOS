//
//  DZMenuTableListView.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/27.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZMenuTableListView.h"
#import "DZDropMenuView.h"

@interface DZMenuTableListView ()<DZDropMenuViewDelegate>

@property (nonatomic, strong) UIButton *menuButton;
@property (nonatomic, strong) UIButton *postButton;  //!< 属性注释
@property (nonatomic, strong) DZForumBaseNode *selectNode;  //!< <#属性注释#>
@property (nonatomic, strong) DZDropMenuView *MenuListView;

@end


@implementation DZMenuTableListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.menuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.width, kToolBarHeight)];
        [self setUpButton:self.menuButton withText:@"区域选择"];
        
        self.MenuListView = [[DZDropMenuView alloc] initWithFrame:CGRectMake(0, kToolBarHeight, self.width, self.height - kToolBarHeight)];
        self.MenuListView.arrowView = self.menuButton.imageView;
        self.MenuListView.delegate = self;
        
        [self addSubview:self.menuButton];
        [self addSubview:self.MenuListView];
        [self addSubview:self.postButton];
        
        /** 最下面横线 */
        UIView *horizontalLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 0.5, KScreenWidth, 0.5)];
        horizontalLine.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1.000];
        [self addSubview:horizontalLine];
    }
    return self;
}

#pragma mark   /********************* 动作交互 *************************/

///   按钮点击推出菜单 (并且其他的菜单收起)
-(void)clickButtonAction:(UIButton *)button{
    
    if (!self.nodeDataArray.count) {
        return;
    }
    [self.MenuListView creatDropView:self withShowTableNum:3 withData:self.nodeDataArray];
}


-(void)postButtonClickAction{
    if (self.selectNode) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(MenuTableView:didSelectCell:)]) {
            [self.delegate MenuTableView:self didSelectCell:self.selectNode];
        }
    }else{
        [DZMobileCtrl showAlertWarn:@"请选择发帖板块"];
    }
}

///   筛选菜单消失
-(void)dismissMenuListView{
    self.selectNode = nil;
    [self.MenuListView dismiss];
}


#pragma mark   /********************* DZDropMenuViewDelegate 代理方法 *************************/

///   协议实现
-(void)DropMenuListView:(DZDropMenuView *)view didSelectNode:(DZForumBaseNode *)indexNode{
    
    self.selectNode = indexNode;
    [self.menuButton setTitle:indexNode.nameStr forState:UIControlStateNormal];
    [self buttonEdgeInsets:self.menuButton];
}


#pragma mark   /********************* 初始化 *************************/

///  设置Button
-(void)setUpButton:(UIButton *)button withText:(NSString *)str{
    
    [button addTarget:self action:@selector(clickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    [button setTitle:str forState:UIControlStateNormal];
    button.titleLabel.font =  [UIFont systemFontOfSize:11];
    button.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [button setTitleColor:[UIColor colorWithWhite:0.3 alpha:1.000] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"manu_downarr"] forState:UIControlStateNormal];
    
    [self buttonEdgeInsets:button];
    
    UIView *verticalLine = [[UIView alloc]init];
    verticalLine.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    [button addSubview:verticalLine];
    verticalLine.frame = CGRectMake(button.frame.size.width - 0.5, 3, 0.5, 30);
}

-(void)buttonEdgeInsets:(UIButton *)button{
    
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -button.imageView.bounds.size.width + 2, 0, button.imageView.bounds.size.width + 10)];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, button.titleLabel.bounds.size.width + 10, 0, -button.titleLabel.bounds.size.width + 2)];
}

- (UIButton *)postButton {
    if (!_postButton) {
        _postButton = [UIButton ButtonTextWithFrame:CGRectMake(kMargin20, self.height - (KTabbar_Height *2), self.width - kMargin40, kToolBarHeight) titleStr:@"发 布" titleColor:[UIColor blackColor] titleTouColor:[UIColor blueColor] font:KBoldFont(18) Radius:4 Target:self action:@selector(postButtonClickAction)];
        _postButton.backgroundColor = [UIColor orangeColor];
    }
    return _postButton;
}




@end










