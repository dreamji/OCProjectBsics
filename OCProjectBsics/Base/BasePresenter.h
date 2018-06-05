//
//  BasePresenter.h
//  AiCommunity
//
//  Created by Tao on 2018/4/12.
//  Copyright © 2018年 NorthStar. All rights reserved.
//

@import Foundation;





@protocol BasePresenterProtocol<NSObject>
@optional
- (void)didBind;
- (void)willUnbind;
@end

@interface BasePresenter : NSObject<BasePresenterProtocol>
@property (nonatomic,weak,readonly) UIView *view;
@property (nonatomic,weak,readonly) UIViewController *viewController;
@property (nonatomic,weak,readonly) UIView *bindView;

- (instancetype)initWithView:(UIView *)view;
- (void)bindView:(UIView *)view;

- (instancetype)initWithViewController:(UIViewController *)viewController;
- (void)bindViewController:(UIViewController *)viewController;
- (void)unbind;

@end
