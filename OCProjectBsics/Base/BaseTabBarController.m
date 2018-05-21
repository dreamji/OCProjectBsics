//
//  BaseTabBarController.m
//  AiCommunity
//
//  Created by Tao on 2018/4/12.
//  Copyright © 2018年 NorthStar. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseTabBar.h"

@interface BaseTabBarController ()
@property (nonatomic,strong) BaseTabBar *customTabbar;
@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tabBar addSubview:self.customTabbar];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex{
    for (UIView *view in self.tabBar.subviews){
        if ([view isKindOfClass:[BaseTabBar class]]){
            continue;
        }
        if ([view isKindOfClass:[UIImageView class]]){
            continue;
        }
        if ([view isKindOfClass:NSClassFromString(@"_UIBarBackground")] || [view isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")]){
            continue;
        }
        [view setHidden:true];
    }
    [self.customTabbar selectedIndex:selectedIndex];
    [super setSelectedIndex:selectedIndex];
}


- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    _customTabbar.frame = self.tabBar.bounds;
    [self.tabBar bringSubviewToFront:_customTabbar];
}

- (BaseTabBar *)customTabbar{
    if (_customTabbar == nil) {
        _customTabbar = [[BaseTabBar alloc] initWithFrame:self.tabBar.bounds];
        _customTabbar.backgroundColor = [UIColor whiteColor];
        [_customTabbar addTabbarItems:@[@"tabicon_home",@"tabicon_msg",@"tabicon_info"]];
        [_customTabbar addTabbarTitles:@[@"小区",@"消息",@"我的"]];
        [_customTabbar selectedIndex:0];
        for(UIButton *button in _customTabbar.items){
            [button addTarget:self action:@selector(tabbarButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return _customTabbar;
}

- (void)tabbarButtonSelected:(UIButton *)button{
    [self.customTabbar selectedIndex:button.tag];
    self.selectedIndex = button.tag;
}


@end
