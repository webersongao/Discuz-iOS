//
//  DZForumController.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/21.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZForumController.h"
#import "PRNaviSegmentView.h"
#import "DZForumNetTool.h"

@interface DZForumController ()<UIScrollViewDelegate,PRNaviSegmentViewDelegate>

@property (nonatomic,assign) int currentIndex;
@property(nonatomic,strong) UIView *sepLineView;
@property (nonatomic, strong) PRNaviSegmentView *ScrollBar;  //!< 属性注释
@property (nonatomic, strong) UIScrollView *scrollView;  //!< 属性注释

@end


@implementation DZForumController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configForumController];
}

-(void)configForumController{
    [self.view addSubview:self.ScrollBar];
    [self.view addSubview:self.scrollView];
    [self configNaviBar:@"bar_message" type:NaviItemImage Direction:NaviDirectionLeft];
    [self configNaviBar:@"bar_search" type:NaviItemImage Direction:NaviDirectionRight];
}

#pragma mark   /********************* 处理数据 *************************/

-(void)sss{
    [DZForumNetTool getVIPCategoryBooKInfoWithColumn:nil subtype:nil pageid:0 success:^(DZVIPCategoryInfoModel * _Nonnull dataModel, NSArray * _Nonnull bookArray) {
        
    } failure:^(id data, NSError *error) {
        
    }];
}


#pragma mark   /********************* 响应事件 *************************/

- (void)leftBarBtnClick {
    if (![self isLogin]) {
        return;
    }
}

- (void)rightBarBtnClick {
    [[DZMobileCtrl sharedCtrl]PushToSearchController];
}


#pragma mark   /********************* PRNaviSegmentViewDelegate *************************/

- (void)naviSegment:(PRNaviSegmentView *)segmentView touchNaviIndex:(NSInteger)index{
    
}

- (void)naviSegment:(PRNaviSegmentView *)segmentView touchSameNaviIndex:(NSInteger)index{
    
}

- (void)naviSegment:(PRNaviSegmentView *)segmentView updateNaviTitleIndex:(NSInteger)index{
    
}

#pragma mark   /********************* UIScrollViewDelegate *************************/

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(!scrollView.isDragging){
        return;
    }
    int index = (scrollView.contentOffset.x  + KScreenWidth * 0.5)/ self.scrollView.width;
    if(self.currentIndex != index){
        self.ScrollBar.segmentView.selectIndex = index;
        self.currentIndex = index;
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int index = scrollView.contentOffset.x / _scrollView.width;
    self.ScrollBar.segmentView.selectIndex = index;
    self.currentIndex = index;
}


-(PRNaviSegmentView *)ScrollBar{
    if (_ScrollBar == nil) {
          _ScrollBar = [[PRNaviSegmentView alloc] initWithFrame:CGRectMake(0, KNavi_ContainStatusBar_Height, KScreenWidth, kToolBarHeight)];
        _ScrollBar.segDelegate = self;
    }
    return _ScrollBar;
}

-(UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.ScrollBar.bottom, KScreenWidth, KScreenHeight - self.ScrollBar.bottom)];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

@end








