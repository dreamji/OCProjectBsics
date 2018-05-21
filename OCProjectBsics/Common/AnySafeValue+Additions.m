//
//  AnySafeValue+Additions.m
//  AiCommunity
//
//  Created by Tao on 2018/4/12.
//  Copyright © 2018年 NorthStar. All rights reserved.
//

#import "AnySafeValue+Additions.h"


@implementation NSString (AnySafeValue)

- (BOOL)isNull{
    if ([self isEqual:[NSNull null]]) {
        return true;
    }
    if (self.length == 0) {
        return true;
    }
    return false;
}

- (double)safeDouble{
    if ([self isNull]) {
        return 0;
    }
    return [self doubleValue];
}
- (float)safeFloat{
    if ([self isNull]) {
        return 0;
    }
    return [self floatValue];
}
- (long long)safeLongLong{
    if ([self isNull]) {
        return 0;
    }
    return [self longLongValue];
}
- (long)safeLong{
    if ([self isNull]) {
        return 0;
    }
    return [self integerValue];
}
- (int)safeInt{
    if ([self isNull]) {
        return 0;
    }
    return [self intValue];
}
- (NSInteger)safeInteger{
    if ([self isNull]) {
        return 0;
    }
    return [self integerValue];
}
- (NSUInteger)safeUInteger{
    if ([self isNull]) {
        return 0;
    }
    return [self integerValue];
}
- (CGFloat)safeCGFloat{
    if ([self isNull]) {
        return 0;
    }
    return [self doubleValue];
}
@end


NSString *safeString(id any){
    if ([any isKindOfClass:[NSString class]]) {
        return (NSString *)any;
    }
    if ([any isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *)any stringValue];
    }
    return @"";
}

NSURL *safeUrl(NSString *url){
    NSString *u = safeString(url);
    if (u.length > 0) {
        return [NSURL URLWithString:u];
    }
    return [NSURL URLWithString:@"u"];
}

NSURL *safeFilePath(NSString *url){
    NSString *u = safeString(url);
    if (u.length > 0) {
        return [NSURL fileURLWithPath:url];
    }
    return [NSURL fileURLWithPath:@"u"];
}


