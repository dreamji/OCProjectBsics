//
//  UIImage+additions.h
//  AiCommunity
//
//  Created by Tao on 2018/4/27.
//  Copyright © 2018年 NorthStar. All rights reserved.
//

@import UIKit;

@interface UIImage(OCProjectBsics_Addtions) 
- (UIImage *)clipImageWithRect:(CGRect)rect;
+ (UIImage *)imageNamed:(NSString *)named bundle:(NSString *)bundle;
@end
