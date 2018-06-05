//
//  CommonMacro.h
//  AiCommunity
//
//  Created by Tao on 2018/4/12.
//  Copyright © 2018年 NorthStar. All rights reserved.
//

#ifndef CommonMacro_h
#define CommonMacro_h


#if TARGET_IPHONE_SIMULATOR
#define isSimulator true
#else
#define isSimulator false
#endif




#define isPad [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad
#define isPhone [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone
#define systemVersion [[UIDevice currentDevice] systemVersion]


#define _ScaleMiddle(args) (args * (_SW/375))
#define _RGB(rgb) [UIColor colorWithRed:((float)((rgb & 0xFF0000) >> 16)) / 255.0 green:((float)((rgb & 0xFF00) >> 8)) / 255.0 blue:((float)(rgb & 0xFF)) / 255.0 alpha:1]
#define _ARGB(rgb,a) [UIColor colorWithRed:((float)((rgb & 0xFF0000) >> 16)) / 255.0 green:((float)((rgb & 0xFF00) >> 8)) / 255.0 blue:((float)(rgb & 0xFF)) / 255.0 alpha:a]


#define _SW MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)
#define _SH MAX([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)

#define iPhone4 (_SH == 480.0)
#define iPhone5 (_SH == 568.0)
#define iPhone6 (_SH == 667.0)
#define iPhone6p (_SH == 736.0)
#define iPhoneX (_SH == 812.0)

#define _TOP  (iPhoneX ? 88 : 64)
#define _BARH (iPhoneX ? 83 : 49)
#define _SBAR (iPhoneX ? 44 : 20)

#define _DocumentsPath NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true).firstObject

#define _S(format,...)[NSString stringWithFormat:format,##__VA_ARGS__]


#define _IMG(name) [UIImage imageNamed:safeString(name)]



#endif /* CommonMacro_h */
