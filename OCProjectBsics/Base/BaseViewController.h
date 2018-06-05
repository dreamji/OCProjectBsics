//
//  BaseViewController.h
//  AiCommunity
//
//  Created by Tao on 2018/4/12.
//  Copyright © 2018年 NorthStar. All rights reserved.
//

@import UIKit;


@class HttpPresenter;
@protocol BaseViewControllerProtocol<NSObject>
- (id)createHttpPresenter;
@end

@interface BaseViewController : UIViewController<BaseViewControllerProtocol>
@property (nonatomic,weak) NSString *navTitle;
@property (nonatomic,weak) HttpPresenter *presenter;
- (void)keyboardListener;
@end
