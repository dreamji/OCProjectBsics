//
//  BaseAppDelegate.h
//  AFNetworking
//
//  Created by Tao on 2018/5/21.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"


@interface BaseAppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,weak) BaseViewController *currentViewController;
@end
