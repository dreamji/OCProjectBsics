//
//  HttpTableView.h
//  AiCommunity
//
//  Created by Tao on 2018/5/8.
//  Copyright © 2018年 NorthStar. All rights reserved.
//

@import UIKit;

@interface HttpTableView : UITableView
@property (nonatomic,strong) NSString *url;
@property (nonatomic,strong) NSDictionary *parameters;
@property (nonatomic,strong) NSMutableArray *dataItems;
- (void)beginRefreshing;


@property(nonatomic,assign) NSInteger page;
@property(nonatomic,assign) NSInteger pageSize;
@property(nonatomic,strong) NSString *httpPageKey;
@property(nonatomic,strong) NSString *httpPageSizeKey;
@property(nonatomic,strong) Class ModelClass;



@end







//@protocol HttpTableViewDataHandle<NSObject>
//@optional
//- (void)tableView:(HttpTableView *)tableView requestSuccess:(id)response page:(NSInteger)page;
//@end


@interface HttpEndingView :UIView
@property (nonatomic,strong) UIImageView *imageView;
@end
