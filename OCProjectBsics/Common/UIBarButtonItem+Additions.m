//
//  UIBarButtonItem+Additions.m
//  AiCommunity
//
//  Created by Tao on 2018/4/23.
//  Copyright © 2018年 NorthStar. All rights reserved.
//

#import "UIBarButtonItem+Additions.h"
#import "Common.h"

@implementation UIBarButtonItem(OCProjectBsics_Addtions)

+ (UIBarButtonItem *)titleLabel:(NSString *)text target:(id)target action:(SEL)action{
    UIBarButtonItem *item = [UIBarButtonItem titleLabel:text font:[UIFont systemFontOfSize:14] color:[UIColor whiteColor] target:target action:action];
    return item;
}

+ (UIBarButtonItem *)titleLabel:(NSString *)text font:(UIFont *)font color:(UIColor *)color target:(id)target action:(SEL)action{
    CGSize size = [text sizeCalculate:font width:200];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, size.width + 10, 30)];
    [button setTitle:text forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    button.titleLabel.font = font;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    return item;
}
@end
