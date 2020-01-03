//
//  DZHomeCollectionCell.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/20.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZHomeCollectionCell.h"
#import "HomeHeader.h"

@interface DZHomeCollectionCell ()

@property (nonatomic, strong) UILabel *NameLabel;  //!< 属性注释
@property (nonatomic, strong) UIImageView *iconImage;  //!< 属性注释

@end


@implementation DZHomeCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self layoutHomeCollectionCell];
    }
    return self;
}


-(void)layoutHomeCollectionCell{
    [self.contentView addSubview:self.iconImage];
    [self.contentView addSubview:self.NameLabel];
}


-(void)updateForumCellWithModel:(DZForumModel *)cellModel{
    _cellModel = cellModel;
    self.NameLabel.text = cellModel.name;
    [self.iconImage sd_setImageWithURL:KURLString(cellModel.icon) placeholderImage:kDeafultCover];
}

-(UIImageView *)iconImage{
    if (_iconImage == nil) {
        _iconImage = [[UIImageView alloc] initWithFrame:CGRectMake((kCellWidth - kHeaderIconHeight)/2.f, 0, kHeaderIconHeight, kHeaderIconHeight)];
        _iconImage.layer.cornerRadius = 8.f;
        _iconImage.layer.masksToBounds = YES;
    }
    return _iconImage;
}

-(UILabel *)NameLabel{
    if (_NameLabel == nil) {
        _NameLabel = [UILabel labelWithFrame:CGRectMake(0, kCellHeight-14.f, kCellWidth, 14.f) title:@"" titleColor:[UIColor blackColor] fontSize:13.f];
    }
    return _NameLabel;
}




@end
