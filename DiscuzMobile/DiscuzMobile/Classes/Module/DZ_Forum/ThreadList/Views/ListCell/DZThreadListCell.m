//
//  DZThreadListCell.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/19.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZThreadListCell.h"

@interface DZThreadListCell ()


@end


@implementation DZThreadListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initBaseGaoThreadCell];
    }
    return self;
}


-(void)initBaseGaoThreadCell{
    
    [self.contentView addSubview:self.cellView];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.cellView.frame = self.bounds;
}


/// @param isTop 是否 置顶帖
- (void)updateThreadCell:(DZThreadListModel *)Model isTop:(BOOL)isTop{
    
    [self.cellView updateThreadView:Model isTop:isTop];

}


-(DZThreadCellView *)cellView{
    if (!_cellView) {
        _cellView = [[DZThreadCellView alloc] init];
    }
    return _cellView;
}


@end
