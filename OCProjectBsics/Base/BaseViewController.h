//
//  BaseViewController.h
//  AiCommunity
//
//  Created by Tao on 2018/4/12.
//  Copyright © 2018年 NorthStar. All rights reserved.
//

@import UIKit;


@protocol BaseViewControllerProtocol<NSObject>
@required
- (void)createHttpPresenter:(id (^)(Class className))creation;
@end

@class HttpPresenter;
@interface BaseViewController : UIViewController
@property (nonatomic,weak) NSString *navTitle;
@property (nonatomic,weak) HttpPresenter *presenter;
- (void)keyboardListener;
@end
