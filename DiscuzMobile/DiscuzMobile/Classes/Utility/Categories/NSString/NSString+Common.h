//
//  NSString+Common.h
//  BaiduShucheng
//
//  Created by Gao on 15/6/17.
//
//

#import <Foundation/Foundation.h>

@interface NSString (Common)

//判断是否为整形
- (BOOL)isPureInt;
//判断是否为浮点型
- (BOOL)isPureFloat;

//检测是否是充值选择金额页面
- (BOOL)checkisContainTBValueUrl;

- (NSArray *)stringToNSArray;

- (NSNumber *)stringToNumber;

+ (NSString *)PRImagePath:(NSString *)imageName;

+ (NSDictionary *)PRParamsURL:(NSString *)url;

+ (NSDictionary *)PRParamsURLNoneDecode:(NSString *)url;

//删除所有的空格及换行
+ (NSString *)removeSpaceAndNewline:(NSString *)str;

+ (CGFloat)cacaulteStringWidth:(NSString *)str fontSize:(int)fontSize;
+ (CGFloat)cacaulteStringHeight:(NSString *)str fontSize:(int)fontSize width:(CGFloat)width;
+ (CGFloat)cacaulteStringHeight:(NSString *)str fontSize:(int)fontSize width:(CGFloat)width lineSpacing:(CGFloat)lineSpacing;



-(CGFloat)textWidthWithSize:(CGSize)size font:(UIFont*)font;

-(CGFloat)textHeightWithSize:(CGSize)size font:(UIFont*)font;

/**
 获取字符串的宽度
 */
- (CGFloat)customStringWidthWithFontSize:(CGFloat)fontSize maxHeight:(CGFloat)height;


@end
