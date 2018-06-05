//
//  BaseNavigationController.m
//  AiCommunity
//
//  Created by Tao on 2018/4/12.
//  Copyright © 2018年 NorthStar. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],
                                                 NSForegroundColorAttributeName:[UIColor whiteColor]}];

}

- (void)setNavigationBarImage:(UIImage *)navigationBarImage{
    _navigationBarImage = navigationBarImage;
    NSInteger leftCapWidth = navigationBarImage.size.width * 0.5;
    NSInteger topCapHeight = navigationBarImage.size.height * 0.5;
    UIImage *newImage = [navigationBarImage stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
    [self.navigationBar setBackgroundImage:newImage forBarPosition:UIBarPositionTop barMetrics:UIBarMetricsDefault];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    viewController.hidesBottomBarWhenPushed = self.viewControllers.count > 0;
    [super pushViewController:viewController animated:animated];
}

- (nullable UIViewController *)popViewControllerAnimated:(BOOL)animated{
    if (self.viewControllers.count == 1) {
        self.viewControllers.firstObject.hidesBottomBarWhenPushed = false;
    }
    return [super popViewControllerAnimated:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end
