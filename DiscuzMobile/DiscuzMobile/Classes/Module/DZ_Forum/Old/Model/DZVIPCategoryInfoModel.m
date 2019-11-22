//
//  DZVIPCategoryInfoModel.m
//  PandaReader
//
//  Created by WebersonGao on 2018/10/25.
//

#import "DZVIPCategoryInfoModel.h"

@implementation DZVIPCategoryInfoModel

/*
 
"bookid": 10075,
"bookname": "护花兵痞",
"bookdesc": "韩食从大山来到都市，美女警花，清纯护士，高傲御姐，可爱萝莉纷纷投怀送抱！看看他这个曾经的妖孽，能在都市花丛中铸就一段怎样的传奇！",
"booktypename": "都市",
"authorname": "古京杭",
"booksize": 168.448,
"frontcover": "https://img.xmkanshu.com/novel/group1/M00/D1/E1/CgoAS1QOcXmAFtOBAABbYSieFHA892.jpg",
"status": 0,
"book_score": 8,
"book_type": 0

*/

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"books" : [PRVIPCategoryBookModel class],
             @"category" : [PRVIPCategoryTypeModel class]
             };
}

@end

@implementation PRVIPCategoryBookModel

@end


@implementation PRVIPCategoryTypeModel

// 模型化数据 到 计算文字宽度和X值
+(void)convertVIPCategoryTypeModel:(PRVIPCategoryTypeModel *)typeModel{
    // 左右各 15.f的间距
    typeModel.booktypeNameWidth = [typeModel.booktypename customStringWidthWithFontSize:15.0 maxHeight:16.0] + 30.f;
}

@end
