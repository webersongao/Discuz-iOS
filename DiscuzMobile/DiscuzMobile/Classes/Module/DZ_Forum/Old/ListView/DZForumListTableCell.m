//
//  DZForumListTableCell.m
//  PandaReader
//
//  Created by WebersonGao on 2018/10/22.
//

#import "DZForumListTableCell.h"

@interface DZForumListTableCell ()

@property(nonatomic,strong) UIImageView *briefView;

@end

@implementation DZForumListTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self loadBriefSubViews];
    }
    return self;
}

- (void)loadBriefSubViews {
    self.briefView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.briefView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.briefView.frame = self.bounds;
}

- (void)updateBookBriefTableViewCell:(id)itemModel {
//    if ([itemModel isKindOfClass:[PRCardBookListItem class]]) {
//        [_briefView updateViewWithModel:itemModel];
//        _briefView.tagsView.left = KScreenWidth - 12.f - self.briefView.tagsView.width;
//    }
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}




@end
