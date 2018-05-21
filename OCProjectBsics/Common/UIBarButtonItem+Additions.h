//
//  UIBarButtonItem+Additions.h
//  AiCommunity
//
//  Created by Tao on 2018/4/23.
//  Copyright © 2018年 NorthStar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIBarButtonItem(Additions)
+ (UIBarButtonItem *)titleLabel:(NSString *)text target:(id)target action:(SEL)action;
+ (UIBarButtonItem *)titleLabel:(NSString *)text font:(UIFont *)font color:(UIColor *)color target:(id)target action:(SEL)action;
@end
