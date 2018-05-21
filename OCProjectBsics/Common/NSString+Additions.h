//
//  NSString+Additions.h
//  AiCommunity
//
//  Created by Tao on 2018/4/12.
//  Copyright © 2018年 NorthStar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Addtions)
-(CGSize)sizeCalculate:(UIFont *)font width:(CGFloat )width;
- (NSString *)md5;
@end
