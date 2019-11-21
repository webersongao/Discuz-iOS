//
//  DZThreadContentView.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/20.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZThreadContentView.h"
#import "DZThreadContentController.h"

@interface DZThreadContentView ()<ThreadListContentDelegate>
@property (nonatomic, strong) DZThreadContentController *contentVC;  //!< 属性注释
@end

@implementation DZThreadContentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self layoutThreadContentView];
        self.backgroundColor = [UIColor yellowColor];
    }
    return self;
}


-(void)layoutThreadContentView{
    [self addSubview:self.contentVC.view];
}

-(void)setOffSetY:(CGPoint)offSet{
    _offSet = offSet;
    self.contentVC.listOffSet = offSet;
}
-(void)setListScrollEnabled:(BOOL)ListScrollEnabled{
    _ListScrollEnabled = ListScrollEnabled;
    self.contentVC.contentScrollEnabled = ListScrollEnabled;
}

#pragma mark   /********************* ThreadListContentDelegate *************************/

- (void)threadListContentView:(UIScrollView *)ScrollView scrollDidScroll:(CGFloat)offsetY{
    if (self.listDelgate && [self.listDelgate respondsToSelector:@selector(threadListContentView:scrollDidScroll:)]) {
        [self.listDelgate threadListContentView:ScrollView scrollDidScroll:offsetY];
    }
}


-(DZThreadContentController *)contentVC{
    if (_contentVC == nil) {
        _contentVC = [[DZThreadContentController alloc] init];
        _contentVC.contentDelegate = self;
    }
    return _contentVC;
}







@end


