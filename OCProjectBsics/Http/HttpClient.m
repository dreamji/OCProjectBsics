//
//  HttpClient.m
//  AiCommunity
//
//  Created by Tao on 2018/4/12.
//  Copyright © 2018年 NorthStar. All rights reserved.
//

#import "HttpClient.h"
#import "AppConfig.h"
#import "HttpBaseModel.h"
#import "HttpToastView.h"
#import "Common.h"

@interface HttpClient()

@end

@implementation HttpClient

- (instancetype)initWithHandel:(id<HttpResponseHandle>)handel
{
    self = [super init];
    if (self) {
        _responseHandle = handel;
        
    }
    return self;
}

- (void)post:(NSString *)url parameters:(NSDictionary<NSString *,id> *)parameters{
    if (AppConfig.shared.reachabilityStatus == AFNetworkReachabilityStatusNotReachable) {
        if ([self.responseHandle respondsToSelector:@selector(didFail:errCode:errInfo:)]) {
            [self.responseHandle didFail:parameters errCode:-1 errInfo:@"Network is not reachable"];
        }
        return;
    }
    
    self.cuurentRequestUrl = url;
    self.cuurentRequestParameters = [self sign:parameters];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setTimeoutInterval:30.f];
    
    __weak typeof(self) weakSelf = self;
    [manager POST:[AppConfig assembleServerUrl:url] parameters:self.cuurentRequestParameters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        HttpBaseModel *model = [HttpBaseModel yy_modelWithJSON:responseObject];
        weakSelf.baseModel = model;
        if (model.success) {
            if ([self.responseHandle respondsToSelector:@selector(willSuccess:)]) {
                [self.responseHandle willSuccess:model.data];
            }
            if ([self.responseHandle respondsToSelector:@selector(didSuccess:)]) {
                [self.responseHandle didSuccess:model.data];
            }
        }else if (model.notLogged){
            ToastViewMessage(self.baseModel.returnMsg);
            UIViewController *vc = [UIStoryboard storyboardWithName:@"Login" bundle:nil].instantiateInitialViewController;
            [((BaseAppDelegate *)[UIApplication sharedApplication].delegate).currentViewController presentViewController:vc animated:true completion:nil];
        }else{
            if ([self.responseHandle respondsToSelector:@selector(didFail:errCode:errInfo:)]) {
                [self.responseHandle didFail:parameters errCode:model.returnCode.safeInteger errInfo:model.returnMsg];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if ([self.responseHandle respondsToSelector:@selector(didFail:errCode:errInfo:)]) {
            [self.responseHandle didFail:parameters errCode:error.code errInfo:error.description];
        }
    }];
}

- (NSDictionary *)sign:(NSDictionary *)parameters{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:parameters];
    if (AppConfig.shared.sign) {
        [dic setValuesForKeysWithDictionary:AppConfig.shared.sign];
    }
    return dic;
}



- (void)upload:(NSString *)url image:(UIImage *)image parameters:(NSDictionary *)parameters{
    if (AppConfig.shared.reachabilityStatus == AFNetworkReachabilityStatusNotReachable) {
        if ([self.responseHandle respondsToSelector:@selector(didFail:errCode:errInfo:)]) {
            [self.responseHandle didFail:@{} errCode:-1 errInfo:@"Network is not reachable"];
        }
        return;
    }
    
    self.cuurentRequestUrl = url;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
    [manager.requestSerializer setTimeoutInterval:30.f];
    
    
    NSData *imageData = UIImageJPEGRepresentation(image, 0.2);
    __weak typeof(self) weakSelf = self;
    [manager POST:[AppConfig assembleServerUrl:url] parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:imageData name:@"fileName" fileName:@"fileName.jpg" mimeType:@"image/jpeg"];//application/octet-stream; charset=UTF-8
    } progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([self.responseHandle respondsToSelector:@selector(willSuccess:)]) {
            [self.responseHandle willSuccess:responseObject];
        }
        if ([weakSelf.responseHandle respondsToSelector:@selector(didSuccess:)]) {
            [weakSelf.responseHandle didSuccess:responseObject];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if ([self.responseHandle respondsToSelector:@selector(didFail:errCode:errInfo:)]) {
            [self.responseHandle didFail:@{} errCode:error.code errInfo:error.description];
        }
    }];
 
}

- (void)download:(NSString *)url{
    if (AppConfig.shared.reachabilityStatus == AFNetworkReachabilityStatusNotReachable) {
        if ([self.responseHandle respondsToSelector:@selector(didFail:errCode:errInfo:)]) {
            [self.responseHandle didFail:@{} errCode:-1 errInfo:@"Network is not reachable"];
        }
        return;
    }
    self.cuurentRequestUrl = url;


    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:[AppConfig assembleServerUrl:self.cuurentRequestUrl]];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];

    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        if (filePath.absoluteString.length > 0 && error == nil) {
            if ([self.responseHandle respondsToSelector:@selector(didSuccess:)]) {
                [self.responseHandle didSuccess:filePath];
            }
        }else{
            if ([self.responseHandle respondsToSelector:@selector(didFail:errCode:errInfo:)]) {
                [self.responseHandle didFail:@{} errCode:error.code errInfo:error.description];
            }
        }
    }];
    [downloadTask resume];
    
}

@end
