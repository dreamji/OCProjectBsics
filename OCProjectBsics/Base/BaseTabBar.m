//
//  BaseTabBar.m
//  AiCommunity
//
//  Created by Tao on 2018/4/12.
//  Copyright © 2018年 NorthStar. All rights reserved.
//

#import "BaseTabBar.h"
#import "Common.h"

@interface BaseTabBar()

@property (nonatomic,strong) NSMutableArray<UILabel *> *labels;
@end

@implementation BaseTabBar

- (void)addTabbarItems:(NSArray<NSString *> *)names {
    
    if (_items == nil) {
        self.items = [NSMutableArray array];
    }
    
    [_items makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_items removeAllObjects];
    
    for (int i = 0; i < names.count; i++) {
        NSString *name = names[i];
        NSString *nname = [NSString stringWithFormat:@"%@_n",name];
        NSString *hname = [NSString stringWithFormat:@"%@_p",name];
        CGFloat w = self.width/names.count;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*w, 0, w, 49);
        [button setImage:[UIImage imageNamed:nname] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:hname] forState:UIControlStateHighlighted];
        [button setImage:[UIImage imageNamed:hname] forState:UIControlStateDisabled];
        [button setImage:[UIImage imageNamed:hname] forState:UIControlStateSelected];
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 10, 0);
        button.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
        button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        button.tag = i;
        [_items addObject:button];
        [self addSubview:button];
        
    }
}

- (void)addTabbarTitles:(NSArray<NSString *> *)titles {
    
    if (_labels == nil) {
        self.labels = [NSMutableArray array];
    }
    
    [_labels makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_labels removeAllObjects];
    
    for (int i = 0; i < titles.count; i++) {
        NSString *title = titles[i];
        CGFloat w = self.width/titles.count;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i*w, 32, w, 14)];
        label.text = title;
        label.font = [UIFont systemFontOfSize:10];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = _RGB(0x989998);
        label.highlightedTextColor = _RGB(0x1277EB);
        label.tag = i + 10;
        [_labels addObject:label];
        [self addSubview:label];
    }
}

- (void)selectedIndex:(NSInteger)index{
    for (UIButton *button in _items){
        if (button.tag == index) {
            button.enabled = false;
        }else{
            button.enabled = true;
        }
    }
    
    for (UILabel *label in _labels){
        if (label.tag == (index + 10)) {
            label.highlighted = true;
        }else{
            label.highlighted = false;
        }
    }
    
}


@end
