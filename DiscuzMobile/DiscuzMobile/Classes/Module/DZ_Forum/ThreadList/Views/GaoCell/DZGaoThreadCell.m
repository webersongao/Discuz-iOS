//
//  DZGaoThreadCell.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/19.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZGaoThreadCell.h"
#import "DZThreadAttach.h"

@interface DZGaoThreadCell ()

@property (nonatomic, strong) UIButton *IconButton;  //!< 头像
@property (nonatomic, strong) UILabel *nameLabel;  //!< 昵称
@property (nonatomic, strong) UILabel *gradeLabel;  //!< 等级
@property (nonatomic, strong) UIImageView *tagLabel;  //!< 置顶 或 精华 标记

@property (nonatomic, strong) UILabel *lineOne;  //!< 分割线

@property (nonatomic, strong) UILabel *mainTitleLabel;  //!< 主标题
@property (nonatomic, strong) UILabel *timeLabel;  //!< 最近更新时间
@property (nonatomic, strong) UILabel *subTitleLabel;  //!< 最新回复

@property (nonatomic, strong) DZThreadAttach *attchView;  //!< 属性注释

@property (nonatomic, strong) UILabel *lineTwo;  //!< 分割线
@property (nonatomic, strong) UIButton *ViewButton;  //!< 浏览数
@property (nonatomic, strong) UIButton *replyButton;  //!< 回复数
@property (nonatomic, strong) UIButton *zanButton;  //!< 点赞数
@property (nonatomic, strong) UILabel *lineThree;  //!< 分割线

@property (nonatomic, strong) DZThreadListModel *cellModel;  //!< 属性注释


@end


@implementation DZGaoThreadCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initBaseGaoThreadCell];
    }
    return self;
}


-(void)initBaseGaoThreadCell{
    
    [self.contentView addSubview:self.IconButton];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.gradeLabel];
    [self.contentView addSubview:self.tagLabel];
    
    [self.contentView addSubview:self.mainTitleLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.subTitleLabel];
    
    [self.contentView addSubview:self.attchView];
    
    [self.contentView addSubview:self.ViewButton];
    [self.contentView addSubview:self.replyButton];
    [self.contentView addSubview:self.zanButton];

}


- (void)updateThreadCell:(DZThreadListModel *)Model{
    
    self.cellModel = Model;
    
    [self.attchView updateUrlList:Model.imglist size:Model.layout.attachFrame.size];
    
}

-(void)layoutThreadCell:(DZThreadLayout *)layout{
    
    
    self.IconButton.frame = layout.iconFrame;
    self.nameLabel.frame = layout.nameFrame;
    self.gradeLabel.frame = layout.gradeFrame;
    self.lineOne.frame = layout.lineOneFrame;
    
    self.lineOne.frame = layout.lineOneFrame;
    
    self.mainTitleLabel.frame = layout.titleFrame;
    self.timeLabel.frame = layout.titleFrame;
    self.subTitleLabel.frame = layout.subtitleFrame;
    
    self.lineTwo.frame = layout.lineTwoFrame;
    self.ViewButton.frame = layout.viewFrame;
    self.replyButton.frame = layout.replyFrame;
    self.zanButton.frame = layout.zanFrame;
    self.lineThree.frame = layout.lineThreeeFrame;
    
    [self.IconButton.layer masksToBounds];
    self.IconButton.layer.cornerRadius = layout.iconFrame.size.width/2.f;
}



#pragma mark   /********************* 初始化 *************************/

- (UIButton *)IconButton{
    if (!_IconButton) {
        _IconButton = [UIButton ButtonNormalWithFrame:CGRectZero title:@"" titleFont:nil titleColor:nil normalImgPath:@"noavatar_small" touchImgPath:@"noavatar_small" isBackImage:YES];
    }
    return _IconButton;
}

-(DZThreadAttach *)attchView{
    if (!_attchView) {
        _attchView = [[DZThreadAttach alloc] initWithFrame:CGRectMake(0, 0, self.width, 90)];
    }
    return _attchView;
}





@end
