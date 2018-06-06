//
//  HttpTableView.m
//  AiCommunity
//
//  Created by Tao on 2018/5/8.
//  Copyright © 2018年 NorthStar. All rights reserved.
//

#import "HttpTableView.h"
#import "HttpClient.h"
#import "HttpStatusView.h"
#import "UIImage+Additions.h"
#import "CommonMacro.h"
@import YYModel;

@import MJRefresh;

@interface HttpTableView()<UITableViewDataSource>
@property (nonatomic,strong) MJRefreshNormalHeader *refreshHeader;
@property (nonatomic,strong) MJRefreshBackNormalFooter *loadMoreFooter;
@property (nonatomic,strong) HttpClient *httpClient;
@property (nonatomic,strong) HttpStatusView *statusView;
@property (nonatomic,strong) HttpEndingView *endingView;
@property (nonatomic,strong) NSString *cellReuseIdentifier;



@end



@implementation HttpTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self config];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self config];
}

- (void)config{
    
    self.httpPageKey = @"currentPage";
    self.httpPageSizeKey = @"pageSize";
    self.ModelClass = NSDictionary.class;

    self.httpClient = [[HttpClient alloc] initWithHandel:self];
    self.refreshHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshTableHeaderDidTriggerRefresh)];
    self.loadMoreFooter = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTableHeaderDidTriggerRefresh)];
    self.refreshHeader.mj_h = 60;
    self.loadMoreFooter.mj_h = 60;
    self.refreshHeader.lastUpdatedTimeLabel.hidden = true;
    self.refreshHeader.backgroundColor = self.backgroundColor;
    self.loadMoreFooter.backgroundColor = self.backgroundColor;
    self.mj_header = _refreshHeader;
    self.url = @"";
    self.parameters = @{};
    self.page = 0;
    self.pageSize = 20;
    self.dataItems = [NSMutableArray array];
    self.delegate = self;
}


- (void)setBackgroundColor:(UIColor *)backgroundColor{
    [super setBackgroundColor:backgroundColor];
    self.refreshHeader.backgroundColor = backgroundColor;
    self.loadMoreFooter.backgroundColor = backgroundColor;
}

- (void)refreshTableHeaderDidTriggerRefresh{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:_parameters];
    self.page = 0;
    dic[_httpPageKey] = @(_page);
    dic[_httpPageSizeKey] = @(_pageSize);
    [self.httpClient post:_url parameters:dic];
    
}

- (void)loadMoreTableHeaderDidTriggerRefresh{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:_parameters];
    dic[_httpPageKey] = @(_page);
    dic[_httpPageSizeKey] = @(_pageSize);
    [self.httpClient post:_url parameters:dic];
}


- (void)didSuccess:(id)response{
    if (self.page == 0) {
        [self.dataItems removeAllObjects];
    }
    self.page += 1;
    NSArray *array = [NSArray yy_modelArrayWithClass:_ModelClass json:response];
    if (array) {
        [self.dataItems addObjectsFromArray:array];
    }
    NSInteger dataCount = [self.dataSource tableView:self numberOfRowsInSection:0];
    if( dataCount == 0){
        self.mj_footer = nil;
        [self.statusView showInView:self mode:HttpStatusNoData msg:@"暂无数据"];
    }else{
        if (dataCount > _pageSize) {
            self.tableFooterView = nil;
            self.mj_footer = _loadMoreFooter;
        }else{
            self.mj_footer = nil;
            self.tableFooterView = self.endingView;
        }
        [self.statusView remove];
        [self reloadData];
    }
    
}

- (void)didFail:(id)response errCode:(NSInteger)errCode errInfo:(NSString *)errInfo{
    [self reloadData];
    [self.statusView showInView:self mode:HttpStatusError msg:@"请求失败了！点击空白处刷新页面" note:errInfo];
}

- (void)endRefreshing{
    [self.refreshHeader endRefreshing];
    [self.loadMoreFooter endRefreshing];
}

- (void)reloadData{
    [super reloadData];
    [self endRefreshing];
    
}

- (void)beginRefreshing{
    if (self.dataItems.count == 0) {
        [self.statusView showInView:self];
    }
    [self refreshTableHeaderDidTriggerRefresh];
}

- (HttpStatusView *)statusView{
    if (_statusView == nil) {
        _statusView = [[HttpStatusView alloc] initWithFrame:CGRectMake(0, 0, _SW, _SH)];
        [_statusView addTarget:self action:@selector(refreshRequest) forControlEvents:UIControlEventTouchUpInside];
    }
    return _statusView;
}
- (void)refreshRequest{
    if (self.statusView.viewMode == HttpStatusError) {
        [self.statusView showInView:self];
        [self refreshTableHeaderDidTriggerRefresh];
    }
}

- (HttpEndingView *)endingView{
    if (_endingView == nil) {
        _endingView = [[HttpEndingView alloc] initWithFrame:CGRectMake(0, 0, _SW, 60)];
    }
    return _endingView;
}

#pragma mark - Delegate
- (void)registerNib:(UINib *)nib forCellReuseIdentifier:(NSString *)identifier{
    [super registerNib:nib forCellReuseIdentifier:identifier];
    self.cellReuseIdentifier = identifier;
}
- (void)registerClass:(Class)cellClass forCellReuseIdentifier:(NSString *)identifier{
    [super registerClass:cellClass forCellReuseIdentifier:identifier];
    self.cellReuseIdentifier = identifier;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataItems.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_cellReuseIdentifier forIndexPath:indexPath];
    return cell;
}
@end

@implementation HttpEndingView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.imageView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake((self.frame.size.width-105)/2, 30, 105, 24);
    
}
- (UIImageView *)imageView{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 105, 24)];
        _imageView.image = [UIImage imageNamed:@"project_ending" bundle:@"OCResource"];
    }
    return _imageView;
}
@end
