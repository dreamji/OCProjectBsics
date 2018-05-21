//
//  BasePresenter.m
//  AiCommunity
//
//  Created by Tao on 2018/4/12.
//  Copyright © 2018年 NorthStar. All rights reserved.
//

#import "BasePresenter.h"


@interface BasePresenter()
@end

@implementation BasePresenter

- (instancetype)initWithView:(UIView *)view
{
    self = [super init];
    if (self) {
        self.view = view;
    }
    return self;
}

- (void)bindView:(UIView *)view{
    self.view = view;
}

- (instancetype)initWithViewController:(UIViewController *)viewController{
    self = [super init];
    if (self) {
        self.viewController = viewController;
    }
    return self;
}
- (void)bindViewController:(UIViewController *)viewController{
    self.viewController = viewController;
}

- (void)unbind{
    if ([self respondsToSelector:@selector(willUnbind)]) {
        [self willUnbind];
    }
    self.view = nil;
    self.viewController = nil;
}


- (void)setView:(UIView *)view{
    _view = view;
    if ([self respondsToSelector:@selector(didBind)]) {
        [self didBind];
    }
    
}

- (void)setViewController:(UIViewController *)viewController{
    _viewController = viewController;
    if ([self respondsToSelector:@selector(didBind)]) {
        [self didBind];
    }
}

- (UIView *)bindView{
    if (self.viewController != nil) {
        return self.viewController.view;
    }else if (self.view != nil){
        return self.view;
    }
    return nil;
}


@end
