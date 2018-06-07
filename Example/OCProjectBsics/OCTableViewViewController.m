//
//  OCTableViewViewController.m
//  OCProjectBsics_Example
//
//  Created by Tao on 2018/6/7.
//  Copyright © 2018年 ssTaoz. All rights reserved.
//

#import "OCTableViewViewController.h"
@import OCProjectBsics;

@interface OCTableViewViewController ()<UITableViewDelegate>
@property (nonatomic,strong) HttpPresenter *customPresenter;
@property (weak, nonatomic) IBOutlet HttpTableView *demoTableView;
@end

@implementation OCTableViewViewController


#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"";
    self.demoTableView.url = @"";
    self.demoTableView.parameters = @{};
    self.demoTableView.ModelClass = NSDictionary.class;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.demoTableView beginRefreshing];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

#pragma mark - Delegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    // do something  cell.titleLable.test = ....
}
#pragma mark - Action

#pragma mark - Public

#pragma mark - Private

#pragma mark - Getter

#pragma mark - Setter

@end
