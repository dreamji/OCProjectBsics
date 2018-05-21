//
//  HttpBaseModel.m
//  AiCommunity
//
//  Created by Tao on 2018/4/13.
//  Copyright © 2018年 NorthStar. All rights reserved.
//

#import "HttpBaseModel.h"
#import "AnySafeValue+Additions.h"

@implementation HttpBaseModel
- (BOOL)success{
    if ([safeString(_returnCode) isEqualToString:@"000000"]) {
        return YES;
    } else {
        return NO;
    }
}
- (BOOL)notLogged{
    if ([safeString(_returnCode) isEqualToString:@"000003"]) {
        return YES;
    } else {
        return NO;
    }
}
@end
