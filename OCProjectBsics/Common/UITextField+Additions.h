//
//  UITextField+Additions.h
//  AiCommunity
//
//  Created by Tao on 2018/4/20.
//  Copyright © 2018年 NorthStar. All rights reserved.
//

@import UIKit;

@interface UITextField (OCProjectBsics_Addtions)
- (void)placeholderLabelColor:(UIColor *)color;
- (void)appendToolBar;
- (void)textFieldLeftLabel:(NSString *)text labelWidth:(CGFloat)labelWidth;
- (void)textFieldLeftIcon:(NSString *)icon iconWidth:(CGFloat)iconWidth;
@end
