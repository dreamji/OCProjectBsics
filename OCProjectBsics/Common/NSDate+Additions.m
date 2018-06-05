//
//  NSDate+Additions.m
//  AiCommunity
//
//  Created by Tao on 2018/4/23.
//  Copyright © 2018年 NorthStar. All rights reserved.
//

#import "NSDate+Additions.h"
#import "OCProjectBsics.h"

@implementation NSDate(OCProjectBsics_Addtions)
- (NSString *)defaultDateFormat{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    return [formatter stringFromDate:self];
}

+ (NSString *)distanceNowTime:(NSTimeInterval)time{
    NSTimeInterval now = [NSDate date].timeIntervalSince1970;
    NSTimeInterval offset = now - time;
    if (offset < 60) {
        return @"1分钟前";
    }else if (offset < 3600) {
        return _S(@"%.0f分钟前",offset/60);
    }else if (offset < 3600) {
        return _S(@"%.0f分钟前",offset/60);
    }else if (offset < 86400) {
        return _S(@"%.0f小时前",offset/60);
    }
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    return date.defaultDateFormat;
}

- (NSString *)aidefaultDateFormat{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [formatter stringFromDate:self];
}


//var distanceNowTime :String{
//    let now :Double  = Date().timeIntervalSince1970
//    let offset = Int(now - self)
//    if offset < 60 {
//        return "1m ago"
//    }else if offset < 3600{
//        return _S("%dm ago", args: offset/60)
//    }else if offset < 86400{
//        return _S("%dh ago", args: offset/3600)
//    }else{
//        let formatter = DateFormatter()
//        formatter.dateFormat = "MM-dd HH:mm"
//        let time = Date(timeIntervalSince1970: self)
//        return formatter.string(from: time)
//    }
//}

@end
