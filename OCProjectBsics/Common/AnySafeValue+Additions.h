//
//  AnySafeValue+Additions.h
//  AiCommunity
//
//  Created by Tao on 2018/4/12.
//  Copyright © 2018年 NorthStar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AnySafeValue)
- (double)safeDouble;
- (float)safeFloat;
- (long long)safeLongLong;
- (long)safeLong;
- (int)safeInt;
- (NSInteger)safeInteger;
- (NSUInteger)safeUInteger;
- (CGFloat)safeCGFloat;
@end

NSString *safeString(id any);
NSURL *safeUrl(NSString *url);
NSURL *safeFilePath(NSString *url);

