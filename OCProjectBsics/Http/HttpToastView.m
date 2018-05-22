//
//  HttpToastView.m
//  AiCommunity
//
//  Created by Tao on 2018/4/18.
//  Copyright © 2018年 NorthStar. All rights reserved.
//

#import "HttpToastView.h"
#import "Common.h"
#import "BaseAppDelegate.h"

@interface HttpToastView()
@property (nonatomic,strong) UILabel *titleLabel;
@end

@implementation HttpToastView

+ (void)message:(NSString *)msg{
    dispatch_async(dispatch_get_main_queue(), ^{
        HttpToastView.shared.content = msg;
    });
}


+ (HttpToastView *)shared{
    static dispatch_once_t predicate;
    static HttpToastView * instance;
    dispatch_once(&predicate, ^{
        instance = [[HttpToastView alloc] init];
        instance.backgroundColor = _ARGB(0x000000, 0.7);
        instance.layer.cornerRadius = 5;
        instance.clipsToBounds = true;
        [instance addSubview:instance.titleLabel];
    });
    return instance;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.titleLabel.frame = self.bounds;
    
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.numberOfLines = 0;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return  _titleLabel;
}


- (void)setContent:(NSString *)content{
    CGSize size = [content sizeCalculate:[UIFont systemFontOfSize:16] width:_SW-40];
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
        CGFloat realHeight = MIN((size.height+16), (_SW - 80));
        self.frame = CGRectMake(0, 0, (size.width + 16), (size.height+16));
        self.center = CGPointMake(_SH/2, (_SW - realHeight - 40));
    }else{
        CGFloat realHeight = MIN((size.height+16), (_SH - 80));
        self.frame = CGRectMake(0, 0, (size.width + 16), (size.height+16));
        self.center = CGPointMake(_SW/2, (_SH - realHeight - 40));
    }
    self.titleLabel.text = content;
    [((BaseAppDelegate *)[UIApplication sharedApplication].delegate).currentViewController.view endEditing:true];
    
    if (self.superview == nil) {
        self.alpha = 0;
        [UIApplication.sharedApplication.keyWindow addSubview:self];
        [UIView animateWithDuration:0.25 animations:^{
            self.alpha = 1;
        } completion:^(BOOL finished) {
            [self performSelector:@selector(remove) withObject:nil afterDelay:2.2];
        }];
    }else{
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(remove) object:nil];
        [UIView animateWithDuration:0.25 animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.25 animations:^{
                self.alpha = 1;
            } completion:^(BOOL finished) {
                [self performSelector:@selector(remove) withObject:nil afterDelay:2.2];
            }];
        }];
    }
}


- (void)remove{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(remove) object:nil];
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}



@end
