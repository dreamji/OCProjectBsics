//
//  AppConfig.m
//  AiCommunity
//
//  Created by Tao on 2018/4/12.
//  Copyright © 2018年 NorthStar. All rights reserved.
//

#import "AppConfig.h"
#import "Common.h"
#import "AFNetworkReachabilityManager.h"

@interface AppConfig()
@property(nonatomic,assign) AFNetworkReachabilityStatus netReachabilityStatus;
@end

@implementation AppConfig


+ (AppConfig *)shared{
    static dispatch_once_t predicate;
    static AppConfig * instance;
    dispatch_once(&predicate, ^{
        instance = [[AppConfig alloc] init];
    });
    return instance;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        _uuid = [self getUuid];
        _bundleID = [self getBundleID];
        _version = [self getVersion];
        _bundleVersion = [self getBundleVersion];
        _netReachabilityStatus = AFNetworkReachabilityStatusReachableViaWiFi;
        [self startMonitoring];
    }
    return self;
}

- (AFNetworkReachabilityStatus)reachabilityStatus{
    return _netReachabilityStatus;
}

- (void)startMonitoring{
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        self.netReachabilityStatus = status;
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

+ (BOOL)firstBoot{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    if(![def boolForKey:@"firstBoot"]){
        [def setBool:YES forKey:@"firstBoot"];
        return true;
    }else{
        return false;
    }
}


- (NSString *)getUuid{
    NSString *bundleID = [self getBundleID];
    NSString *uuid = [SAMKeychain passwordForService:bundleID account:@"UUID"];
    if (uuid.length == 0) {
        uuid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        [SAMKeychain setPassword:uuid forService:bundleID account:@"UUID"];
    }
    return uuid;
}


- (NSString *)getBundleID{
    id name = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
    return safeString(name);
}
- (NSString *)getVersion{
    id version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    return safeString(version);
}
- (NSString *)getBundleVersion{
    id version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    return safeString(version);
}

+ (NSString *)assembleServerUrl:(NSString *)url{
    NSString *u = [NSString stringWithFormat:@"%@%@",AppConfig.shared.server_url,url];
    NSLog(@"assembleServerUrl---------<\n%@\n",u);
    return u;
}

+ (NSString *)assembleServerFileUrl:(NSString *)url{
    NSString *u = [NSString stringWithFormat:@"%@%@",AppConfig.shared.server_file_url,url];
    NSLog(@"assembleServerFileUrl---------<\n%@\n",u);
    return u;
}

@end
