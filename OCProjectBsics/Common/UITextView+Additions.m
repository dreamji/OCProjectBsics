//
//  UITextView+Additions.m
//  AiCommunity
//
//  Created by Tao on 2018/6/1.
//  Copyright © 2018年 NorthStar. All rights reserved.
//

#import "UITextView+Additions.h"

@implementation UITextView(OCProjectBsics_Addtions)
- (void)appendToolBar{
    UIToolbar *tool = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 40)];
    tool.barTintColor = [UIColor colorWithRed:162/255.0 green:168/255.0 blue:180/255.0 alpha:1];
    UIBarButtonItem *spce = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *hide = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissKeyBoard)];
    tool.items = @[spce,spce,spce,hide];
    self.inputAccessoryView = tool;
    
}
- (void)dismissKeyBoard{
    [self resignFirstResponder];
}
@end
