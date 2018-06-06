//
//  OCBaseViewController.m
//  OCProjectBsics_Example
//
//  Created by Tao on 2018/6/6.
//  Copyright © 2018年 ssTaoz. All rights reserved.
//

#import "OCBaseViewController.h"
#import "OCTestPresenter.h"
@import OCProjectBsics;

@interface OCBaseViewController ()<BaseViewControllerProtocol>
@property (nonatomic,strong) OCTestPresenter *ocPresenter;
@end

@implementation OCBaseViewController

- (void)createHttpPresenter:(id (^)(__unsafe_unretained Class))completion{
    self.ocPresenter = completion(OCTestPresenter.class);
}

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (void)dealloc
{
    NSLog(@"OCBaseViewController dealloc");
}
    
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    ;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

#pragma mark - Delegate

#pragma mark - Action

#pragma mark - Public

#pragma mark - Private

#pragma mark - Getter

#pragma mark - Setter

@end
