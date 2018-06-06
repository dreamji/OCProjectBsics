//
//  UIImage+additions.m
//  AiCommunity
//
//  Created by Tao on 2018/4/27.
//  Copyright © 2018年 NorthStar. All rights reserved.
//

#import "UIImage+Additions.h"

@implementation UIImage(OCProjectBsics_Addtions)
- (UIImage *)clipImageWithRect:(CGRect)rect{
    
    //将UIImage转换成CGImageRef
    CGImageRef sourceImageRef = [self CGImage];
    
    //按照给定的矩形区域进行剪裁
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    
    //将CGImageRef转换成UIImage
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    //返回剪裁后的图片
    return newImage;
    

}

+ (UIImage *)imageNamed:(NSString *)named bundle:(NSString *)bundle{
    NSString *path = [[NSBundle mainBundle] pathForResource:bundle ofType:@"bundle"];
    NSBundle *resource = [NSBundle bundleWithPath:path];
    NSString *postfix = [[UIScreen mainScreen] scale] > 2 ? @"@3x" : @"@2x";
    NSString *file = [resource pathForResource:[NSString stringWithFormat:@"%@%@",named,postfix] ofType:@"png"];
    return [UIImage imageWithContentsOfFile:file];
}


@end
