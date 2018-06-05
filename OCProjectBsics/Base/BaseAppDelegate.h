//
//  BaseAppDelegate.h
//  AFNetworking
//
//  Created by Tao on 2018/5/21.
//

@import UIKit;


@interface BaseAppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,weak) UIViewController *currentViewController;
@end
