//
//  HttpBaseModel.h
//  AiCommunity
//
//  Created by Tao on 2018/4/13.
//  Copyright © 2018年 NorthStar. All rights reserved.
//


@import Foundation;

@interface HttpBaseModel : NSObject
@property (nonatomic, strong) NSString *returnCode;
@property (nonatomic, strong) NSString *returnMsg;
@property (nonatomic, strong) id data;
- (BOOL)success;
- (BOOL)notLogged;
@end
