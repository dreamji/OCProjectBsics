//
//  HttpPresenter.m
//  AiCommunity
//
//  Created by Tao on 2018/4/12.
//  Copyright © 2018年 NorthStar. All rights reserved.
//

#import "HttpPresenter.h"
#import "CommonMacro.h"
#import "HttpClient.h"
#import "HttpStatusView.h"

@interface HttpPresenter()

@property (nonatomic,strong) HttpStatusView *httpStatusView;
@end


@implementation HttpPresenter

- (instancetype)init
{
    self = [super init];
    if (self) {
        _httpClient = [[HttpClient alloc] initWithHandel:self];
    }
    return self;
}

- (instancetype)initWithView:(id)view{
    self =  [super initWithView:view];
    if (self) {
        _httpClient = [[HttpClient alloc] initWithHandel:self];
    }
    return self;
}

- (instancetype)initWithViewController:(id)viewController{
    self =  [super initWithViewController:viewController];
    if (self) {
        _httpClient = [[HttpClient alloc] initWithHandel:self];
    }
    return self;
}


#pragma mark -request
- (void)request:(NSString *)url{
    [self request:url parameters:@{}];
}
- (void)request:(NSString *)url parameters:(NSDictionary *)parameters{
    [self request:url parameters:parameters method:Post];
}

- (void)request:(NSString *)url parameters:(NSDictionary *)parameters method:(HTTPMethod)method{
    [self.httpStatusView showInView:self.viewController.view];
    [self.httpClient post:url parameters:parameters];
}

- (void)upload:(NSString *)url image:(UIImage *)image parameters:(NSDictionary *)parameters{
    [self.httpStatusView showInView:self.viewController.view];
    [self.httpClient upload:url image:image parameters:parameters];
}

- (void)willSuccess:(id)response{
    if ([response isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = response;
        if (dic.allValues.count == 0) {
            [self.statusView showInView:self.bindView mode:HttpStatusNoData msg:@"暂无数据"];
            return;
        }
    }
    [self.statusView remove];
}

- (void)didFail:(id)response errCode:(NSInteger)errCode errInfo:(NSString *)errInfo{
    [self.statusView showInView:self.bindView mode:HttpStatusError msg:@"SORRY~ \n请求失败了！点击空白处刷新页面" note:errInfo];
}


#pragma mark -httpStatusView
- (HttpStatusView *)httpStatusView{
    if (_httpStatusView == nil) {
        _httpStatusView = [[HttpStatusView alloc] initWithFrame:CGRectMake(0, 0, _SW, _SH)];
        [_httpStatusView addTarget:self action:@selector(refreshRequest) forControlEvents:UIControlEventTouchUpInside];
    }
    return _httpStatusView;
}

- (void)refreshRequest{
    [self request:self.httpClient.cuurentRequestUrl parameters:self.httpClient.cuurentRequestParameters];
}

- (HttpStatusView *)statusView{
    return self.httpStatusView;
}

@end
