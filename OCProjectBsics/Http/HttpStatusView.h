//
//  HttpStatusView.h
//  AiCommunity
//
//  Created by Tao on 2018/4/13.
//  Copyright © 2018年 NorthStar. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum : NSUInteger {
    HttpStatusNoData,
    HttpStatusError,
    HttpStatusLoading,
} HttpStatusViewDisplayMode;

@interface HttpStatusView : UIControl
@property(nonatomic,readonly) HttpStatusViewDisplayMode viewMode;
- (void)showInView:(UIView *)view;
- (void)showInView:(UIView *)view mode:(HttpStatusViewDisplayMode)mode;
- (void)showInView:(UIView *)view mode:(HttpStatusViewDisplayMode)mode msg:(NSString *)msg;
- (void)showInView:(UIView *)view mode:(HttpStatusViewDisplayMode)mode msg:(NSString *)msg note:(NSString *)note;
- (void)showInView:(UIView *)view mode:(HttpStatusViewDisplayMode)mode msg:(NSString *)msg note:(NSString *)note animate:(BOOL)animate;
- (void)remove;
@end
