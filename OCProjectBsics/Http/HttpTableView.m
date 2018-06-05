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
#import "CommonMacro.h"
@import MJRefresh;

@interface HttpTableView()<HttpResponseHandle>
@property (nonatomic,strong) MJRefreshNormalHeader *refreshHeader;
@property (nonatomic,strong) MJRefreshBackNormalFooter *loadMoreFooter;
@property (nonatomic,strong) HttpClient *httpClient;
@property (nonatomic,assign) NSInteger page;
@property (nonatomic,assign) NSInteger pageSize;
@property (nonatomic,strong) HttpStatusView *statusView;
@property (nonatomic,strong) HttpEndingView *endingView;
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
    
}

- (void)setBackgroundColor:(UIColor *)backgroundColor{
    [super setBackgroundColor:backgroundColor];
    self.refreshHeader.backgroundColor = backgroundColor;
    self.loadMoreFooter.backgroundColor = backgroundColor;
}

- (void)refreshTableHeaderDidTriggerRefresh{
    [self.dataItems removeAllObjects];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:_parameters];
    self.page = 0;
    dic[@"currentPage"] = @(_page);
    dic[@"pageSize"] = @(_pageSize);
    [self.httpClient post:_url parameters:dic];
    
}

- (void)loadMoreTableHeaderDidTriggerRefresh{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:_parameters];
    dic[@"currentPage"] = @(_page);
    dic[@"pageSize"] = @(_pageSize);
    [self.httpClient post:_url parameters:dic];
}

- (void)didSuccess:(id)response{
    self.page += 1;
    if ([self.delegate respondsToSelector:@selector(tableView:requestSuccess:page:)]) {
        const HttpTableView *strongSelf = self;
        NSMethodSignature *sig = [[self.delegate class] instanceMethodSignatureForSelector:@selector(tableView:requestSuccess:page:)];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:sig];
        invocation.target = self.delegate;
        invocation.selector = @selector(tableView:requestSuccess:page:);
        [invocation setArgument:&strongSelf atIndex:2];
        [invocation setArgument:&response atIndex:3];
        [invocation setArgument:&_page atIndex:4];
        [invocation invoke];
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
@end

@implementation HttpEndingView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = _RGB(0xF5F5F5);
//        [self addSubview:self.leftLine];
//        [self addSubview:self.rightLine];
//        [self addSubview:self.titleLabel];
    }
    return self;
}

//- (void)layoutSubviews{
//    [super layoutSubviews];
//    self.titleLabel.frame = CGRectMake(self.width/2-35, self.height/2-10, 70, 20);
//    self.leftLine.frame = CGRectMake(15, self.height/2, _titleLabel.left - 20, 1);
//    self.rightLine.frame = CGRectMake(_titleLabel.right + 5, self.height/2, self.leftLine.width, 1);
//}
//
//- (UIView *)leftLine{
//    if (_leftLine == nil) {
//        _leftLine = [[UIView alloc] initWithFrame:CGRectZero];
//        _leftLine.backgroundColor = _RGB(0xDCDCDC);
//    }
//    return _leftLine;
//}
//- (UIView *)rightLine{
//    if (_rightLine == nil) {
//        _rightLine = [[UIView alloc] initWithFrame:CGRectZero];
//        _rightLine.backgroundColor = _RGB(0xDCDCDC);
//    }
//    return _rightLine;
//}
//- (UILabel *)titleLabel{
//    if (_titleLabel == nil) {
//        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//        _titleLabel.font = [UIFont systemFontOfSize:11];
//        _titleLabel.textColor = _RGB(0xB0B0B0);
//        _titleLabel.textAlignment = NSTextAlignmentCenter;
//        _titleLabel.text = @"我是有底线的";
//    }
//    return _titleLabel;
//}

@end
