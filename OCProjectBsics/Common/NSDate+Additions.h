//
//  NSDate+Additions.h
//  AiCommunity
//
//  Created by Tao on 2018/4/23.
//  Copyright © 2018年 NorthStar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate(Additions) 
- (NSString *)defaultDateFormat;
- (NSString *)aidefaultDateFormat;
+ (NSString *)distanceNowTime:(NSTimeInterval)time;
@end
