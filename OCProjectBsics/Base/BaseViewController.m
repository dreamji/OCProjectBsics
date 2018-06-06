//
//  BaseViewController.m
//  AiCommunity
//
//  Created by Tao on 2018/4/12.
//  Copyright © 2018年 NorthStar. All rights reserved.
//

#import "BaseViewController.h"
#import "HttpPresenter.h"
#import "BaseAppDelegate.h"
#import "AnySafeValue+Additions.h"
#import "NSString+Additions.h"
#import "CommonMacro.h"


@interface BaseViewController ()<BaseViewControllerProtocol>

@end

@implementation BaseViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"";

    self.navigationController.interactivePopGestureRecognizer.enabled = true;
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    self.navigationController.navigationBar.backIndicatorImage = [UIImage imageNamed:@"login_back_icon"];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"login_back_icon"];
    self.navigationItem.backBarButtonItem = backItem;
    
    if ([self respondsToSelector:@selector(createHttpPresenter:)]) {
        [self createHttpPresenter:^id(__unsafe_unretained Class className) {
            id p = [[className alloc] init];
            self.presenter = p;
            return p;
        }];
    }

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.presenter bindViewController:self];
    ((BaseAppDelegate *)[UIApplication sharedApplication].delegate).currentViewController = self;
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [NSNotificationCenter.defaultCenter removeObserver:self];
    [self.presenter unbind];
}

- (void)keyboardListener{
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(keyboardWillhide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)note{
    CGRect keyboardRect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    double d = safeString(note.userInfo[UIKeyboardAnimationDurationUserInfoKey]).safeDouble;
    CGFloat y = keyboardRect.size.height;
    [UIView animateWithDuration:d animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, -y);
    }];
}

- (void)keyboardWillhide:(NSNotification *)note{
    double d = safeString(note.userInfo[UIKeyboardAnimationDurationUserInfoKey]).safeDouble;
    [UIView animateWithDuration:d animations:^{
        self.view.transform = CGAffineTransformIdentity;
    }];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


- (void)setNavTitle:(NSString *)navTitle{
    CGFloat w = [navTitle sizeCalculate:[UIFont systemFontOfSize:15] width:_SW-100].width;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, w, 30)];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"STHeitiK-Medium" size:15];
    label.textColor = [UIColor whiteColor];
    label.text = navTitle;
    self.navigationItem.titleView = label;
}


//- (void)createHttpPresenter:(Class)class completion:(void (^)(id presenter))completion{
//    self.presenter = [[class alloc] init];
//    completion(_presenter);
//}


@end
