//
//  DZHomeCollectionView.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/19.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeHeader.h"
#import "DZHomeCollectionCell.h"

@class DZHomeCollectionView,DZHomeCollectionCell;
@protocol HeaderCollectionDelegate <NSObject>
@optional
- (void)collectionView:(DZHomeCollectionView *)collectionView didSelectItemCell:(DZHomeCollectionCell *)itemCell indexPath:(NSIndexPath *)indexPath;

- (void)collectionView:(DZHomeCollectionView *)collectionView longPressItemCell:(DZHomeCollectionCell *)itemCell;

- (void)collectionView:(DZHomeCollectionView *)collectionView scrollDidScroll:(CGFloat)offsetY;

- (void)collectionViewWillBeginDragging;

- (void)collectionViewDidEndScroll;

@end

@interface DZHomeCollectionView : UICollectionView

+(UICollectionViewFlowLayout *)gridLayout;
@property(nonatomic,strong,readonly) NSArray *dataArray;
@property(nonatomic,weak) id<HeaderCollectionDelegate> headerDelegate;



// 重置 书架数组数据 的唯一方法
-(void)reloadDataSource:(NSArray <DZForumInfoModel *>*)array;
@end


