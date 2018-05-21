//
//  HttpPresenter.h
//  AiCommunity
//
//  Created by Tao on 2018/4/12.
//  Copyright © 2018年 NorthStar. All rights reserved.
//

#import "BasePresenter.h"
#import "HttpClient.h"
#import "HttpToastView.h"
#import "HttpStatusView.h"



typedef enum : NSUInteger {
    Post,
} HTTPMethod;


@interface HttpPresenter : BasePresenter <HttpResponseHandle>
@property (nonatomic,weak,readonly) HttpStatusView *statusView;
@property (nonatomic,strong,readonly) HttpClient *httpClient;

- (void)request:(NSString *)url;
- (void)request:(NSString *)url parameters:(NSDictionary *)parameters;
- (void)request:(NSString *)url parameters:(NSDictionary *)parameters method:(HTTPMethod)method;

- (void)upload:(NSString *)url image:(UIImage *)image parameters:(NSDictionary *)parameters;

@end
