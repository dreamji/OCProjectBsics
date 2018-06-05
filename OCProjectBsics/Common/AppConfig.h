//
//  AppConfig.h
//  AiCommunity
//
//  Created by Tao on 2018/4/12.
//  Copyright © 2018年 NorthStar. All rights reserved.
//

@import Foundation;



@interface AppConfig : NSObject
+ (AppConfig *)shared;
@property(nonatomic,readonly,strong) NSString *uuid;
@property(nonatomic,readonly,strong) NSString *bundleID;
@property(nonatomic,readonly,strong) NSString *version;
@property(nonatomic,readonly,strong) NSString *bundleVersion;
@property(nonatomic,readonly,assign) NSInteger reachabilityStatus;

@property(nonatomic,strong) NSDictionary *sign;
@property(nonatomic,strong) NSString *server_url;
@property(nonatomic,strong) NSString *server_file_url;

+ (BOOL)firstBoot;

+ (NSString *)assembleServerUrl:(NSString *)url;
+ (NSString *)assembleServerFileUrl:(NSString *)url;


@end
