//
//  NSDate+Additions.h
//  AiCommunity
//
//  Created by Tao on 2018/4/23.
//  Copyright © 2018年 NorthStar. All rights reserved.
//

@import UIKit;

@interface NSDate(OCProjectBsics_Addtions) 
- (NSString *)defaultDateFormat;
- (NSString *)aidefaultDateFormat;
+ (NSString *)distanceNowTime:(NSTimeInterval)time;
@end
