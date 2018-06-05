//
//  BaseTabBar.h
//  AiCommunity
//
//  Created by Tao on 2018/4/12.
//  Copyright © 2018年 NorthStar. All rights reserved.
//

@import UIKit;

@interface BaseTabBar : UIView
@property (nonatomic,strong) NSMutableArray<UIButton *> *items;
- (void)addTabbarItems:(NSArray<NSString *> *)names;
- (void)addTabbarTitles:(NSArray<NSString *> *)titles;
- (void)selectedIndex:(NSInteger)index;
@end
