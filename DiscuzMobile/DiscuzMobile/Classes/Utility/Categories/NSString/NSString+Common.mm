//
//  NSString+Common.m
//  BaiduShucheng
//
//  Created by Gao on 15/6/17.
//
//

#import "NSString+Common.h"

@implementation NSString (Common)

//判断是否为整形
- (BOOL)isPureInt{
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

//判断是否为浮点型
- (BOOL)isPureFloat{
    NSScanner* scan = [NSScanner scannerWithString:self];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

- (BOOL)checkisContainTBValueUrl
{
    NSString *regex = @"^.*tb=([0-9a-zA-Z]+).*$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([predicate evaluateWithObject:self] )
    {
        return YES;
    }
    return NO;
}

- (NSArray *)stringToNSArray{
    if (self.length) {
        NSString * muString = [NSString removeSpaceAndNewline:self];
        muString = [muString stringByReplacingOccurrencesOfString:@"(" withString:@""];
        muString = [muString stringByReplacingOccurrencesOfString:@")" withString:@""];
        
        NSArray *localArr =  [muString componentsSeparatedByString:@","];
        return localArr;
    }
    return nil;
}

- (NSNumber *)stringToNumber {
    NSInteger integer = [self integerValue];
    NSNumber *number = [NSNumber numberWithInteger:integer];
    return number;
}

+ (NSString *)PRImagePath:(NSString *)imageName
{
    NSString * itemPath = [NSString stringWithFormat:@"skin/onlineMenu/%@",imageName];
    return itemPath;
}

// 将url的参数部分转化成字典
+ (NSDictionary *)PRParamsURL:(NSString *)url
{
    
    NSMutableDictionary* pairs = [NSMutableDictionary dictionary];
    if (NSNotFound != [url rangeOfString:@"?"].location) {
        NSString *paramString = [url substringFromIndex:
                                 ([url rangeOfString:@"?"].location + 1)];
        NSCharacterSet* delimiterSet = [NSCharacterSet characterSetWithCharactersInString:@"&"];
        NSScanner* scanner = [[NSScanner alloc] initWithString:paramString];
        while (![scanner isAtEnd]) {
            NSString* pairString = nil;
            [scanner scanUpToCharactersFromSet:delimiterSet intoString:&pairString];
            [scanner scanCharactersFromSet:delimiterSet intoString:NULL];
            NSArray* kvPair = [pairString componentsSeparatedByString:@"="];
            if (kvPair.count == 2) {
                NSString* key = [[kvPair objectAtIndex:0] stringByRemovingPercentEncoding];
                NSString* value = [[kvPair objectAtIndex:1] stringByRemovingPercentEncoding];
                [pairs setValue:value forKey:key];
            }
        }
    }
    return [NSDictionary dictionaryWithDictionary:pairs];
}

+ (NSDictionary *)PRParamsURLNoneDecode:(NSString *)url
{
    
    NSMutableDictionary* pairs = [NSMutableDictionary dictionary];
    if (NSNotFound != [url rangeOfString:@"?"].location) {
        NSString *paramString = [url substringFromIndex:
                                 ([url rangeOfString:@"?"].location + 1)];
        NSCharacterSet* delimiterSet = [NSCharacterSet characterSetWithCharactersInString:@"&"];
        NSScanner* scanner = [[NSScanner alloc] initWithString:paramString];
        while (![scanner isAtEnd]) {
            NSString* pairString = nil;
            [scanner scanUpToCharactersFromSet:delimiterSet intoString:&pairString];
            [scanner scanCharactersFromSet:delimiterSet intoString:NULL];
            NSArray* kvPair = [pairString componentsSeparatedByString:@"="];
            if (kvPair.count == 2) {
                NSString* key = [kvPair objectAtIndex:0];
                NSString* value = [kvPair objectAtIndex:1];
                [pairs setValue:value forKey:key];
            }
        }
    }
    return [NSDictionary dictionaryWithDictionary:pairs];
}

//删除所有的空格及换行
+ (NSString *)removeSpaceAndNewline:(NSString *)str
{
    NSString *temp = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return temp;
}

+ (CGFloat)cacaulteStringWidth:(NSString *)str fontSize:(int)fontSize {
    
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize],};
    
    CGSize textSize = [str boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 0) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    
    return textSize.width;
}

+ (CGFloat)cacaulteStringHeight:(NSString *)str fontSize:(int)fontSize width:(CGFloat)width {
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize],};
    
    CGSize textSize = [str boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
    
    if (textSize.height < fontSize*2) { //一行
        textSize.height = fontSize;
    }
    
    return textSize.height;
}

+ (CGFloat)cacaulteStringHeight:(NSString *)str fontSize:(int)fontSize width:(CGFloat)width lineSpacing:(CGFloat)lineSpacing
{
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    
    CGSize textSize = [str boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
    
    textSize.height = ceil(textSize.height);
    return textSize.height;
}



-(CGFloat)textWidthWithSize:(CGSize)size font:(UIFont*)font{
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size.width;
}

-(CGFloat)textHeightWithSize:(CGSize)size font:(UIFont*)font{
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size.height;
}


/**
 获取字符串的宽度
 */
- (CGFloat)customStringWidthWithFontSize:(CGFloat)fontSize maxHeight:(CGFloat)height
{
    if (!self.length) {
        return 0;
    }
    if (fontSize < 1) {
        fontSize = 14.0;
    }
    if (height < 1) {
        height = 14.0;
    }
    NSDictionary *fontDict = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};  //指定字号
    CGRect rect = [self boundingRectWithSize:CGSizeMake(0, height)/*计算宽度时要确定高度*/ options:NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading attributes:fontDict context:nil];
    return rect.size.width;
}

@end
