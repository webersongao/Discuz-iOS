//
//  DZVIPCategoryInfoModel.h
//  PandaReader
//
//  Created by WebersonGao on 2018/10/25.
//

#import <Foundation/Foundation.h>

@class PRVIPCategoryBookModel;
@class PRVIPCategoryTypeModel;

NS_ASSUME_NONNULL_BEGIN

@interface DZVIPCategoryInfoModel : NSObject

@property (nonatomic,assign) NSInteger is_next;
@property (nonatomic,strong) NSArray<PRVIPCategoryTypeModel *> *category; //分类
@property (nonatomic,strong) NSArray<PRVIPCategoryBookModel *> *books; //图书list数组
// 自定义字段 本地使用的模型化之后数据
@property (nonatomic,strong) NSArray *localBooks; //图书list数组

@end

@interface PRVIPCategoryBookModel : NSObject

@property (nonatomic,copy) NSString *href;
@property (nonatomic,copy) NSString *bookid;
@property (nonatomic,copy) NSString *bookname; //书名
@property (nonatomic,copy) NSString *authorname; //作者
@property (nonatomic,copy) NSString *bookdesc; //描述
@property (nonatomic,copy) NSString *booktypename; //图书类型标签
@property (nonatomic,strong) NSNumber *booksize; //字数resType
@property (nonatomic,assign) NSInteger status; //状态
@property (nonatomic,copy) NSString *frontcover; //图片路径
@property (nonatomic,strong) NSNumber *book_score; //评分
@property (nonatomic,assign) NSInteger book_type; //0小说 1出版物 2漫画 3音频


@end

@interface PRVIPCategoryTypeModel : NSObject

@property (nonatomic,copy) NSString *booktypeid;
@property (nonatomic,copy) NSString *booktypename; //书名

// 自定义属性
@property (nonatomic,assign) CGFloat booktypeNameX; //书名X值
@property (nonatomic,assign) CGFloat booktypeNameWidth; //书名宽度 (含左右各15.f的间距)

// 模型化数据 到 计算文字宽度和X值
+(void)convertVIPCategoryTypeModel:(PRVIPCategoryTypeModel *)typeModel;

@end

NS_ASSUME_NONNULL_END
