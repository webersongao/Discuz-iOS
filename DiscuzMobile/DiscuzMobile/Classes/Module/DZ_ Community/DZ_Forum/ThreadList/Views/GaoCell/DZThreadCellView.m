//
//  DZThreadCellView.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/24.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZThreadCellView.h"
#import "DZThreadAttach.h"
#import "UILabel+TopTitle.h"
#import "DZThreadListModel.h"

@interface DZThreadCellView ()

@property (nonatomic, strong) UILabel *nameLabel;  //!< 昵称
@property (nonatomic, strong) UILabel *gradeLabel;  //!< 等级
@property (nonatomic, strong) UIImageView *tagView;  //!< 置顶 或 精华 标记

@property (nonatomic, strong) UIView *lineOne;  //!< 分割线

@property (nonatomic, strong) UILabel *mainTitleLabel;  //!< 主标题
@property (nonatomic, strong) UILabel *timeLabel;  //!< 最近更新时间
@property (nonatomic, strong) UILabel *subTitleLabel;  //!< 最新回复

@property (nonatomic, strong) DZThreadAttach *attchView;  //!< 属性注释

@property (nonatomic, strong) UIView *lineTwo;  //!< 分割线

@property (nonatomic, strong) UIButton *ViewButton;  //!< 浏览数
@property (nonatomic, strong) UIButton *replyButton;  //!< 回复数

@property (nonatomic, strong) UIView *lineThree;  //!< 分割线

@property (nonatomic, strong,readonly) DZThreadListModel *threadModel;  //!< 属性注释

@end


@implementation DZThreadCellView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self comfigThreadView];
    }
    return self;
}

-(void)comfigThreadView{
    [self addSubview:self.IconButton];
    [self addSubview:self.nameLabel];
    [self addSubview:self.gradeLabel];
    [self addSubview:self.tagView];
    
    [self addSubview:self.lineOne];
    
    [self addSubview:self.mainTitleLabel];
    [self addSubview:self.timeLabel];
    [self addSubview:self.subTitleLabel];
    
    [self addSubview:self.attchView];
    
    [self addSubview:self.lineTwo];
    [self addSubview:self.ViewButton];
    [self addSubview:self.replyButton];
    [self addSubview:self.zanButton];
    
    [self addSubview:self.lineThree];
}


/// @param isTop 是否 置顶帖
- (void)updateThreadView:(DZThreadListModel *)Model isTop:(BOOL)isTop{
    
    _threadModel = Model;
    
    self.nameLabel.text = Model.author;
    self.tagView.image = Model.tagImage;
    self.gradeLabel.text = Model.gradeName;
    
    [self layoutThreadCell:Model.listLayout];
    
    
    if (!isTop) {
        self.mainTitleLabel.text = Model.mainTitleString;
    }else{
        [self.mainTitleLabel setText:Model.mainTitleString andImageName:@"置顶" andSize:CGSizeMake(34 ,17) andPosition:P_before];
    }
    self.subTitleLabel.text = Model.lastReplyString;
    
    self.subTitleLabel.numberOfLines = 0;
    self.timeLabel.text = Model.dateline;
    
    [self.ViewButton setTitle:checkTwoStr(@"浏览：", Model.views) forState:UIControlStateNormal];
    [self.replyButton setTitle:checkTwoStr(@"回复：", Model.replies) forState:UIControlStateNormal];
    [self.zanButton setTitle:checkTwoStr(@"点赞：", Model.recommend_add) forState:UIControlStateNormal];
    
    self.zanButton.selected = [Model.recommend isEqualToString:@"1"];
    self.zanButton.enabled = [Model.recommend isEqualToString:@"1"] ? NO : YES;
    [self.attchView updateUrlList:Model.imglist size:Model.listLayout.attachFrame.size];
    [self.IconButton sd_setImageWithURL:[NSURL URLWithString:Model.avatar] forState:UIControlStateNormal];
    
}

-(void)layoutThreadCell:(DZThreadLayout *)layout{
    
    self.IconButton.frame = layout.iconFrame;
    self.nameLabel.frame = layout.nameFrame;
    self.gradeLabel.frame = layout.gradeFrame;
    self.tagView.frame = layout.tagFrame;
    
    self.lineOne.frame = layout.lineOneFrame;
    
    self.mainTitleLabel.frame = layout.titleFrame;
    self.timeLabel.frame = layout.timeFrame;
    self.subTitleLabel.frame = layout.subtitleFrame;
    
    self.attchView.frame = layout.attachFrame;
    
    self.lineTwo.frame = layout.lineTwoFrame;
    
    self.ViewButton.frame = layout.viewFrame;
    self.replyButton.frame = layout.replyFrame;
    self.zanButton.frame = layout.zanFrame;
    
    self.lineThree.frame = layout.lineThreeeFrame;
    
    self.IconButton.layer.cornerRadius = layout.iconFrame.size.width/2.f;
    self.IconButton.clipsToBounds = YES;
}



#pragma mark   /********************* 初始化 *************************/

- (UIButton *)IconButton{
    if (!_IconButton) {
        _IconButton = [UIButton ButtonNormalWithFrame:CGRectZero title:@"" titleFont:nil titleColor:nil normalImgPath:@"noavatar_small" touchImgPath:@"noavatar_small" isBackImage:YES];
    }
    return _IconButton;
}

-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [UILabel labelWithFrame:CGRectZero title:@"--" titleColor:KColor(K2A2C2F_Color, 1.0) font:KFont(14) textAlignment:NSTextAlignmentLeft];
    }
    return _nameLabel;
}

-(UILabel *)gradeLabel{
    if (!_gradeLabel) {
        _gradeLabel = [UILabel labelWithFrame:CGRectZero title:@"" titleColor:KColor(K2A2C2F_Color, 1.0) font:KFont(12) textAlignment:NSTextAlignmentLeft];
    }
    return _gradeLabel;
}

-(UIImageView *)tagView{
    if (!_tagView) {
        _tagView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _tagView;
}

-(UIView *)lineOne{
    if (!_lineOne) {
        _lineOne = [[UIView alloc] init];
        _lineOne.backgroundColor = KColor(KLine_Color, 1.0);
    }
    return _lineOne;
}


-(UILabel *)mainTitleLabel{
    if (!_mainTitleLabel) {
        _mainTitleLabel = [UILabel labelWithFrame:CGRectZero title:@"" titleColor:KColor(K2A2C2F_Color, 1.0) font:KBoldFont(16) textAlignment:NSTextAlignmentLeft];
        _mainTitleLabel.numberOfLines = 1;
    }
    return _mainTitleLabel;
}

-(UILabel *)subTitleLabel{
    if (!_subTitleLabel) {
        _subTitleLabel = [UILabel labelWithFrame:CGRectZero title:@"" titleColor:KColor(K2A2C2F_Color, 1.0) font:KFont(14) textAlignment:NSTextAlignmentLeft];
        _subTitleLabel.numberOfLines = 0;
    }
    return _subTitleLabel;
}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [UILabel labelWithFrame:CGRectZero title:@"" titleColor:KColor(K2A2C2F_Color, 1.0) font:KFont(12.f) textAlignment:NSTextAlignmentRight];
    }
    return _timeLabel;
}

-(DZThreadAttach *)attchView{
    if (!_attchView) {
        _attchView = [[DZThreadAttach alloc] initWithFrame:CGRectMake(0, 0, self.width, 90)];
    }
    return _attchView;
}

-(UIView *)lineTwo{
    if (!_lineTwo) {
        _lineTwo = [[UIView alloc] init];
        _lineTwo.backgroundColor = KColor(KLine_Color, 1.0);
    }
    return _lineTwo;
}

- (UIButton *)ViewButton{
    if (!_ViewButton) {
        _ViewButton = [UIButton ButtonNormalWithFrame:CGRectZero title:@"浏览: -" titleFont:KFont(12) titleColor:KColor(K2A2C2F_Color, 1.0) normalImgPath:@"list_see" touchImgPath:@"list_see" isBackImage:NO];
        [_ViewButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsImageLeft imageTitleSpace:5];
    }
    return _ViewButton;
}

- (UIButton *)replyButton{
    if (!_replyButton) {
        _replyButton = [UIButton ButtonNormalWithFrame:CGRectZero title:@"回复: -" titleFont:KFont(12) titleColor:KColor(K2A2C2F_Color, 1.0) normalImgPath:@"list_message" touchImgPath:@"list_message" isBackImage:NO];
        [_replyButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsImageLeft imageTitleSpace:5];
    }
    return _replyButton;
}

- (UIButton *)zanButton{
    if (!_zanButton) {
        _zanButton = [UIButton ButtonNormalWithFrame:CGRectZero title:@"点赞: -" titleFont:KFont(12) titleColor:KColor(K2A2C2F_Color, 1.0) normalImgPath:@"list_zan" touchImgPath:@"list_zan_high" isBackImage:NO];
        [_zanButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsImageLeft imageTitleSpace:5];
    }
    return _zanButton;
}

-(UIView *)lineThree{
    if (!_lineThree) {
        _lineThree = [[UIView alloc] init];
        _lineThree.backgroundColor = KColor(KLine_Color, 1.0);
    }
    return _lineThree;
}



@end
