//
//  HttpClient.h
//  AiCommunity
//
//  Created by Tao on 2018/4/12.
//  Copyright © 2018年 NorthStar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpBaseModel.h"


@protocol HttpResponseHandle<NSObject>
@optional
- (void)willSuccess:(id)response;
- (void)didSuccess:(id)response;
- (void)didFail:(id)response errCode:(NSInteger)errCode errInfo:(NSString *)errInfo;
@end


@interface HttpClient : NSObject
@property (nonatomic,strong) NSString *cuurentRequestUrl;
@property (nonatomic,strong) NSDictionary *cuurentRequestParameters;
@property (nonatomic,strong) HttpBaseModel *baseModel;
@property (nonatomic,weak) id<HttpResponseHandle> responseHandle;
- (instancetype)initWithHandel:(id<HttpResponseHandle>)handel;

- (void)post:(NSString *)url parameters:(NSDictionary<NSString *,id> *)parameeters;
- (void)upload:(NSString *)url image:(UIImage *)image parameters:(NSDictionary *)parameters;
- (void)download:(NSString *)url;
@end
