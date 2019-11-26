//
//  DZDiscoverController.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/21.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZDiscoverController.h"
#import "PRNaviSegmentView.h"
#import "DZDiscoverNetTool.h"
#import "DZDiscoverCateController.h"

@interface DZDiscoverController ()<UIScrollViewDelegate,PRNaviSegmentViewDelegate>

@property (nonatomic,assign) int currentIndex;
@property(nonatomic,strong) UIView *sepLineView;
@property (nonatomic, strong) UIScrollView *scrollView;  //!< 属性注释
@property (nonatomic, strong) PRNaviSegmentView *ScrollBar;  //!< 属性注释
@property(nonatomic,strong) NSMutableArray<DZDiscoverCateController*> *listViewArray;

@end


@implementation DZDiscoverController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configForumController];
    [self loadViewIndexDataIfNeeded];
}
-(BOOL)hideTabBarWhenPushed{
    return NO;
}
-(void)configForumController{
    [self.view addSubview:self.ScrollBar];
    [self.view addSubview:self.scrollView];
    self.listViewArray = [NSMutableArray array];
    [self configNaviBar:@"版块" type:NaviItemText Direction:NaviDirectionLeft];
    [self configNaviBar:@"bar_search" type:NaviItemImage Direction:NaviDirectionRight];
}

#pragma mark   /********************* 处理数据 *************************/

-(void)loadViewIndexDataIfNeeded{
    KWEAKSELF
    [DZDiscoverNetTool getForumCategoryInfo:YES forum:^(NSArray <DZDiscoverCateModel *> * cateList, NSArray <DZBaseForumModel *> * forumList) {
        [weakSelf layoutForumList:cateList forumList:forumList];
    }];
}

-(void)layoutForumList:(NSArray <DZDiscoverCateModel *>*)cateList forumList:(NSArray <DZBaseForumModel *>*)forumList{
    
    //1、 处理分类导航条
    
    //2、处理分类页面
    NSMutableArray *titleArray = [NSMutableArray arrayWithCapacity:3];
    for (int index = 0; index < forumList.count; index ++) {
        DZBaseForumModel *model = forumList[index];
        [titleArray addObject:checkNull(model.name)];
        DZDiscoverCateController *listVC = [[DZDiscoverCateController alloc] initWithFrame:CGRectMake(index * self.scrollView.width, 0, self.scrollView.width, self.scrollView.height) Model:model];
        [self.listViewArray addObject:listVC];
        [self.scrollView addSubview:listVC.view];
    }
    
    [self.ScrollBar updateNaviBarWithTitle:titleArray];
    self.scrollView.contentSize = CGSizeMake(forumList.count * KScreenWidth, _scrollView.height);
}




#pragma mark   /********************* 响应事件 *************************/

- (void)leftBarBtnClick {
    [[DZMobileCtrl sharedCtrl] PushToAllForumViewController];
}

- (void)rightBarBtnClick {
    [[DZMobileCtrl sharedCtrl] PushToSearchController];
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








