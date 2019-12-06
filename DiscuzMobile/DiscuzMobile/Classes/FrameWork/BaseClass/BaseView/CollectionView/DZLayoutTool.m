//
//  DZLayoutTool.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/25.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZLayoutTool.h"
@implementation DZLayoutTool

// 九宫格模式 布局
+ (UICollectionViewFlowLayout *)gridLayout{
    
    UICollectionViewFlowLayout * gridLayout = [[UICollectionViewFlowLayout alloc] init];
    gridLayout.minimumLineSpacing = 10.f;
    gridLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    gridLayout.itemSize = CGSizeMake(kCellWidth, kCellHeight);
    gridLayout.minimumLineSpacing = kLineSpacing;
    gridLayout.minimumInteritemSpacing = kItemSpacing;
    gridLayout.sectionInset = UIEdgeInsetsMake(0,kCellMargins, kCellMargins, kCellMargins);
    
    return gridLayout;
}

// 列表 列表模式 布局
+ (UICollectionViewFlowLayout *)listLayout{
    
    UICollectionViewFlowLayout * listLayout = [[UICollectionViewFlowLayout alloc] init];
    listLayout.minimumLineSpacing = 10.f;
    listLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    listLayout.itemSize = CGSizeMake(KScreenWidth, kCellWidth);
    listLayout.minimumLineSpacing = 0;  // 行间距 (上下间隔)
    listLayout.minimumInteritemSpacing = 0;  // 列间距 (左右间隔)
    listLayout.sectionInset = UIEdgeInsetsMake(0,kCellMargins, kCellMargins, kCellMargins);
    
    return listLayout;
}

// 瀑布流 布局
+ (UICollectionViewFlowLayout *)waterLayout{
    
    UICollectionViewFlowLayout * waterLayout = [[UICollectionViewFlowLayout alloc] init];
    waterLayout.minimumLineSpacing = 10.f;
    waterLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    waterLayout.itemSize = CGSizeMake(KScreenWidth, kCellWidth);
    waterLayout.minimumLineSpacing = 0;  // 行间距 (上下间隔)
    waterLayout.minimumInteritemSpacing = 0;  // 列间距 (左右间隔)
    waterLayout.sectionInset = UIEdgeInsetsMake(0,kCellMargins, kCellMargins, kCellMargins);
    
    return waterLayout;
}



@end







