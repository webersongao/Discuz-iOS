//
//  DZDiscoverSquareCell.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/22.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZDiscoverSquareCell.h"

@implementation DZDiscoverSquareCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configDiscoverSquareCell];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.cellView.frame = self.bounds;
}

-(void)configDiscoverSquareCell{

    [self.contentView addSubview:self.cellView];
}

- (void)updateThreadInnerCell:(DZThreadListModel *)Model isTop:(BOOL)isTop{
    
    [self.cellView updateThreadCellView:Model];
}



-(DZThreadCellView *)cellView{
    if (!_cellView) {
        _cellView = [[DZThreadCellView alloc] init];
    }
    return _cellView;
}



@end












