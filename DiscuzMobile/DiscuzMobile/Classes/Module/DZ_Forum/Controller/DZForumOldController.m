//
//  DZHomeController.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/19.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZForumOldController.h"
#import "PRTagSegmentView.h"
#import "PRNetWorkErrorView.h"
#import "DZVIPCategoryInfoModel.h"
#import "DZForumNetTool.h"
#import "DZForumCateListController.h"

@interface DZForumOldController ()<PRTagSegmentViewDelegate,UIScrollViewDelegate,PRNetWorkErrorViewDelegate>


@property (nonatomic,assign) int currentIndex;
@property(nonatomic,strong) UIView *sepLineView;
@property (nonatomic,copy) NSString *columntype;
@property(nonatomic,strong) UIScrollView *scrollView;
@property(nonatomic,strong) PRNetWorkErrorView *errorView;
@property(nonatomic,strong) PRTagSegmentView *segmentView;
@property(nonatomic,strong) UIScrollView *segmentScrollView;
@property(nonatomic,strong) DZVIPCategoryInfoModel *bookDataModel;
@property(nonatomic,strong) NSMutableArray<DZForumCateListController*> *listViewArray;


@end

@implementation DZForumOldController

- (instancetype)initWithTitle:(NSString *)title column:(NSString *)column
{
    self = [super init];
    if (self) {
        self.title = title;
        self.columntype = column;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshSeprateLineView:) name:@"refreshSeprateLineViewNotification" object:nil];
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self configCatagorySegmentView];
    [self loadRootViewDataFromServer:YES];
}


-(void)configCatagorySegmentView{
    
    self.currentIndex = 0;
    [self.view addSubview:self.segmentScrollView];
    [self.view addSubview:self.scrollView];
    self.listViewArray = [[NSMutableArray alloc] initWithCapacity:3];
    
    // 分割线
    self.sepLineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.segmentScrollView.height-0.5, self.segmentScrollView.width, 0.5)];
    self.sepLineView.backgroundColor = KColor(@"#E2E2E5", 1.0);
    self.sepLineView.hidden = YES;
    [self.segmentScrollView addSubview:self.sepLineView];
    
    [self configNaviBar:@"bar_message" type:NaviItemImage Direction:NaviDirectionLeft];
    [self configNaviBar:@"bar_search" type:NaviItemImage Direction:NaviDirectionRight];
}

-(void)loadRootViewDataFromServer:(BOOL)bFirstLoad{
    
    NSString *subtype = @"0";
    NSString *pageid = @"0";
    
    if (!self.columntype.length){
        [self addErrorView:PRErrorViewNoData];
        return;
    }else if (![DZMobileCtrl connectedNetwork]){
        [self addErrorView:PRErrorViewNoNet];
        return;
    }
    [self.HUD showLoadingMessag:nil toView:self.view];
    KWEAKSELF
    [DZForumNetTool getVIPCategoryBooKInfoWithColumn:self.columntype subtype:subtype pageid:pageid success:^(DZVIPCategoryInfoModel * _Nonnull dataModel, NSArray * _Nonnull bookArray) {
        [self.HUD hideAnimated:YES];
        [weakSelf removeErrorview];
        weakSelf.bookDataModel = dataModel;
        // 初始化 顶部tab条
        if (bFirstLoad && !weakSelf.listViewArray.count) {
            [weakSelf setUpSegmentHeaderView:dataModel];
        }
        [weakSelf.listViewArray[weakSelf.currentIndex] loadChildsViewFirstDataFromServer];
    } failure:^(id data, NSError *error) {
        [self.HUD hideAnimated:YES];
        [weakSelf addErrorView:PRErrorViewNoData];
    }];
}

-(void)refreshSeprateLineView:(NSNotification *)notify{
    
    NSNumber *OffsetYValue = [notify.userInfo objectForKey:@"contentOffsetY"];
    BOOL bShowLine = (OffsetYValue.floatValue <= 0);
    if (bShowLine != self.sepLineView.isHidden) {
        self.sepLineView.hidden = bShowLine;
    }
}


#pragma -mark PRTagSegmentViewDelegate

- (void)navisegment:(PRTagSegmentView *)segment updateIndex:(NSInteger)index{
    
    index = (index >= self.bookDataModel.category.count) ? self.bookDataModel.category.count - 1 : (index < 0 ? 0 : index);
    
    if(!self.scrollView.isDragging){
        [self.scrollView setContentOffset:CGPointMake(index * self.scrollView.width, 0) animated:NO];
    }
    self.currentIndex = index;
    
    [self.listViewArray[self.currentIndex] loadChildsViewFirstDataFromServer];
    
    [self selectTitleButtonAnimation:index];
}


#pragma -mark UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(!scrollView.isDragging){
        return;
    }
    int index = (scrollView.contentOffset.x  + KScreenWidth * 0.5)/ self.scrollView.width;
    if(self.currentIndex != index){
        self.segmentView.selectIndex = index;
        self.currentIndex = index;
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int index = scrollView.contentOffset.x / _scrollView.width;
    self.segmentView.selectIndex = index;
    self.currentIndex = index;
}

 /********************* 响应事件 *************************/
- (void)leftBarBtnClick {
    if (![self isLogin]) {
        return;
    }
}

- (void)rightBarBtnClick {
    [[DZMobileCtrl sharedCtrl]PushToSearchController];
}


#pragma -mark PRNetWorkErrorViewDelegate
- (void)tryAgainButtonDidClicked {
    [self loadRootViewDataFromServer:YES];
}


-(void)setUpSegmentHeaderView:(DZVIPCategoryInfoModel *)dataModel{
    
    // 计算title文字宽度
    for (PRVIPCategoryTypeModel *model in dataModel.category) {
        [PRVIPCategoryTypeModel convertVIPCategoryTypeModel:model];
    }
    
    if (dataModel.category.count) {
        NSMutableArray *booktypeArray = [[NSMutableArray alloc] init];
        NSMutableArray* recArray = [[NSMutableArray alloc] init];
        CGFloat segmentViewWidth = 0;
        
        BOOL isSegNameWidth = NO;
        CGFloat segmentNameWidth = 0;
        for (PRVIPCategoryTypeModel * titleModel in dataModel.category) {
            segmentNameWidth += titleModel.booktypeNameWidth;
        }
        if (segmentNameWidth < KScreenWidth) {
            // 不够一屏幕的宽度时候 则均分(长标题有可能被裁剪)
            isSegNameWidth = YES;
        }
        NSInteger categoryCount = dataModel.category.count;
        for (int i = 0; i < categoryCount; i++)
        {
            PRVIPCategoryTypeModel *listModel = dataModel.category[i];
            CGFloat titleWidth = isSegNameWidth ? (KScreenWidth/categoryCount) : listModel.booktypeNameWidth;
            listModel.booktypeNameWidth = titleWidth;
            listModel.booktypeNameX = segmentViewWidth;
            CGRect rect = CGRectMake(segmentViewWidth, 0, titleWidth, 44);
            segmentViewWidth += titleWidth;
            [recArray addObject:[NSValue valueWithCGRect:rect]];
            
            [booktypeArray addObject:listModel.booktypename];
            
            DZForumCateListController *listVC = [[DZForumCateListController alloc] initWithFrame:CGRectMake(i * self.scrollView.width, 0, self.scrollView.width, self.scrollView.height)];
            listVC.subtype = listModel.booktypeid;
            listVC.column = self.columntype;
            [self.scrollView addSubview:listVC.view];
            [self.listViewArray addObject:listVC];
        }
        segmentViewWidth = MAX(segmentViewWidth, KScreenWidth);
        [self.segmentView setTabArr:booktypeArray rect:recArray];
        [self.segmentView setupAllItems:NO];
        self.segmentScrollView.contentSize = CGSizeMake(segmentViewWidth, 44.f);
        self.sepLineView.width = self.segmentView.width = segmentViewWidth;
        self.scrollView.contentSize = CGSizeMake(dataModel.category.count * KScreenWidth, _scrollView.height);
    }else{
//        [self.topBar.backImageView addSubview:self.sepLineView];
//        self.sepLineView.frame = CGRectMake(0, self.topBar.bottom-0.5, KScreenWidth, 0.5);
        self.scrollView.frame = CGRectMake(0, KNavi_ContainStatusBar_Height, KScreenWidth, KScreenHeight- KNavi_ContainStatusBar_Height);
        self.scrollView.contentSize = CGSizeMake(KScreenWidth, _scrollView.height);
        DZForumCateListController *listVC = [[DZForumCateListController alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, self.scrollView.height)];
        listVC.subtype = @"0";
        self.currentIndex = 0;
        listVC.column = self.columntype;
        [self.scrollView addSubview:listVC.view];
        [self.listViewArray addObject:listVC];
    }
}


- (void)selectTitleButtonAnimation:(NSInteger)index
{
    if (index < 0 || index >= self.bookDataModel.category.count || self.segmentScrollView.contentSize.width <= KScreenWidth) {
        // 如果index异常 或者 contentSize的宽度小于frame的宽度，直接返回，不用调整scrollView的contentOffset
        return;
    }
    
    PRVIPCategoryTypeModel *listModel = self.bookDataModel.category[index];
    
    // selItem中点到contentSize左边距离
    CGFloat selectButtonX = listModel.booktypeNameX;
    
    CGSize contentSize = self.segmentScrollView.contentSize;
    
    CGFloat edgeLeftToSelItemCenterX = selectButtonX;
    // selItem中点到contentSize右边距离
    CGFloat edgeRightToSelItemCenterX = contentSize.width - edgeLeftToSelItemCenterX;
    
    CGFloat targetX = 0.0;
    if (edgeLeftToSelItemCenterX < KScreenWidth / 2.0) { //如果selItem中点到左边的距离小于bounds宽度的一半，scrollView滑到最左边
        targetX = 0.0;
    } else if (edgeRightToSelItemCenterX < KScreenWidth / 2.0) { //如果selItem中点到右边的距离小于bounds宽度的一半，scrollView滑到最右边
        targetX = contentSize.width - KScreenWidth;
    } else {     //将selItem置中
        targetX = edgeLeftToSelItemCenterX - KScreenWidth / 2.0;
    }
    [self.segmentScrollView setContentOffset:CGPointMake(targetX, 0) animated:YES];
    
}

- (void)addErrorView:(PRErrorViewType)errorType {
    [self.errorView addErrorViewWithViewType:errorType];
    [self.view addSubview:self.errorView];
}

- (void)removeErrorview {
    if (self.errorView && self.errorView.superview) {
        [self.errorView removeFromSuperview];
    }
}


-(UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.segmentScrollView.bottom, KScreenWidth, KScreenHeight - self.segmentScrollView.bottom)];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (PRNetWorkErrorView *)errorView {
    if (!_errorView) {
        _errorView = [[PRNetWorkErrorView alloc] initWithFrame:CGRectMake(0, KNavi_ContainStatusBar_Height, KScreenWidth, KScreenHeight) viewType:PRErrorViewNoNet];
        _errorView.delegate = self;
    }
    return _errorView;
}

-(UIScrollView *)segmentScrollView{
    if (_segmentScrollView == nil) {
        CGRect segeHeaderRect = CGRectMake(0, 64 + KNavigation_Bar_Gap, KScreenWidth, 44);
        _segmentScrollView = [[UIScrollView alloc] initWithFrame:segeHeaderRect];
        _segmentScrollView.showsHorizontalScrollIndicator = NO;
        _segmentScrollView.bounces = NO;
        
        _segmentView = [[PRTagSegmentView alloc] initWithFrame:CGRectMake(0, 0, segeHeaderRect.size.width, segeHeaderRect.size.height) screenType:kSegNormal];
        _segmentView.backgroundColor = [UIColor whiteColor];
        _segmentView.titleColor = KColor(@"#31323E", 1.0);
        _segmentView.titleHightColor = KColor(@"#33C3A5", 1.0);
        _segmentView.selectLineColor = KColor(@"#33C3A5", 1.0);
        _segmentView.titleFont = KFont(15.f);
        _segmentView.titleSelectFont = KBoldFont(15.f);
        _segmentView.delegate = self;
        _segmentView.fixedLineWidth = 35 * 0.5;
        [_segmentScrollView addSubview:_segmentView];
    }
    return _segmentScrollView;
}


-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    //    LogMsg(@" ++++++++ DZForumOldController dealloc ");
}

@end
