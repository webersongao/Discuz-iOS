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

@property (nonatomic, strong) DZDropMenuView *MenuListView;


@end


@implementation DZMenuTableListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.menuButton.frame = self.bounds;
        [self setUpButton:self.menuButton withText:@"区域选择"];
        
        self.MenuListView = [[DZDropMenuView alloc] init];
        self.MenuListView.arrowView = self.menuButton.imageView;
        self.MenuListView.delegate = self;
        
        /** 最下面横线 */
        UIView *horizontalLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 0.5, KScreenWidth, 0.5)];
        horizontalLine.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1.000];
        [self addSubview:horizontalLine];
        
    }
    return self;
}



#pragma mark - 按钮点击推出菜单 (并且其他的菜单收起)
-(void)clickButton:(UIButton *)button{
    
    [self.MenuListView creatDropView:self withShowTableNum:3 withData:self.dataArray];
    
}

#pragma mark - 筛选菜单消失
-(void)dismissMenuListView{

    [self.MenuListView dismiss];
}


#pragma mark - 协议实现
-(void)DZDropMenuView:(DZDropMenuView *)view didSelectName:(NSString *)String{
    
    DLog(@"当前的 选项是 %@",String);
    [self.menuButton setTitle:String forState:UIControlStateNormal];
    [self buttonEdgeInsets:self.menuButton];
    
}





#pragma mark - 设置Button
-(void)setUpButton:(UIButton *)button withText:(NSString *)str{
    
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
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




-(NSArray *)dataArray{
    if (_dataArray == nil) {
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"dz_address.plist" ofType:nil]];
        _dataArray = dic[@"address"];
    }
    return _dataArray;
}

@end
