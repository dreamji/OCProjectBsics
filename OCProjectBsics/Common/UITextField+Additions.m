//
//  UITextField+Additions.m
//  AiCommunity
//
//  Created by Tao on 2018/4/20.
//  Copyright © 2018年 NorthStar. All rights reserved.
//

#import "UITextField+Additions.h"

@implementation UITextField (Addtions)

- (void)placeholderLabelColor:(UIColor *)color{
    [self setValue:color forKeyPath:@"_placeholderLabel.textColor"];
}

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

- (void)textFieldLeftLabel:(NSString *)text labelWidth:(CGFloat)labelWidth{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0,labelWidth, self.frame.size.height)];
    view.backgroundColor = self.backgroundColor;
    if (text.length > 0){
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, labelWidth-20, self.frame.size.height)];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = self.font;
        label.text = text;
        [view addSubview:label];
    }
    self.leftView = view;
    self.leftViewMode = UITextFieldViewModeAlways;
    
}

- (void)textFieldLeftIcon:(NSString *)icon iconWidth:(CGFloat)iconWidth{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0,iconWidth, self.frame.size.height)];
    view.backgroundColor = self.backgroundColor;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,15, 15)];
    imageView.center = view.center;
    imageView.image = [UIImage imageNamed:icon];
    [view addSubview:imageView];
    self.leftView = view;
    self.leftViewMode = UITextFieldViewModeAlways;
}


@end
