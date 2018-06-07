//
//  NSString+Additions.m
//  AiCommunity
//
//  Created by Tao on 2018/4/12.
//  Copyright © 2018年 NorthStar. All rights reserved.
//

#import "NSString+Additions.h"
#import "CommonCrypto/CommonDigest.h"
#import "AnySafeValue+Additions.h"

@implementation NSString (OCProjectBsics_Addtions)
-(CGSize)sizeCalculate:(UIFont *)font width:(CGFloat )width
{
    CGSize stringSize = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                           options:(NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin)
                                        attributes:@{NSFontAttributeName : font}
                                           context:nil].size;
    return stringSize;
}

- (NSString *)md5{
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}
///@"yyyy-MM-dd"
- (NSString *)dateFormat:(NSString *)format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:self.safeDouble];
    return [formatter stringFromDate:date];
}

- (NSDate *)dateFromString:(NSString *)format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter dateFromString:self];
}
@end
