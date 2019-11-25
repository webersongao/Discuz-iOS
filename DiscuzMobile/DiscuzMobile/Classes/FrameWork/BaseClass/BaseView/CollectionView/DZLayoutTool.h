//
//  DZLayoutTool.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/25.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import <Foundation/Foundation.h>


#define  kLineSpacing       KWidthScale(20.f)   //    行间距 |
#define  kItemSpacing       KWidthScale(10.f)  //    item之间的最小列间距  实际上是自动计算
#define  kCellMargins       KWidthScale(15.f)  //    左右缩进
#define  kRowNumber         3    //列数
#define  kCellWidth         KWidthScale(105.f)  //    Cell宽度
#define  kCellHeight        KWidthScale(150.f)  //    Cell高度 // kCellWidth + kCellTextSpace + kCellTextHeight


@interface DZLayoutTool : NSObject

// 九宫格模式 布局
+ (UICollectionViewFlowLayout *)gridLayout;

// 列表 列表模式 布局
+ (UICollectionViewFlowLayout *)listLayout;

// 瀑布流 布局
+ (UICollectionViewFlowLayout *)waterLayout;



@end


