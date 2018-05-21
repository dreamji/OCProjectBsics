//
//  HttpToastView.h
//  AiCommunity
//
//  Created by Tao on 2018/4/18.
//  Copyright © 2018年 NorthStar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HttpToastView : UIView
+ (HttpToastView *)shared;
@property (nonatomic,weak) NSString *content;
+ (void)message:(NSString *)msg;
@end


#define ToastViewMessage(msg) ([HttpToastView message:msg])
