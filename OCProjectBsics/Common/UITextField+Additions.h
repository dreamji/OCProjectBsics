//
//  UITextField+Additions.h
//  AiCommunity
//
//  Created by Tao on 2018/4/20.
//  Copyright © 2018年 NorthStar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Addtions)
- (void)placeholderLabelColor:(UIColor *)color;
- (void)appendToolBar;
- (void)textFieldLeftLabel:(NSString *)text labelWidth:(CGFloat)labelWidth;
- (void)textFieldLeftIcon:(NSString *)icon iconWidth:(CGFloat)iconWidth;
@end
