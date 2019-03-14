//
//  AppMacro.h
//  LoveClass
//
//  Created by apple on 16/8/30.
//  Copyright © 2016年 cyfuer. All rights reserved.
//

#ifndef AppMacro_h
#define AppMacro_h

#pragma mark - DEBUG模式下打印代码所在位置

#ifdef DEBUG
#define AppLog(s, ... ) NSLog( @"[%@ in line %d] ===============>%@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define AppLog(s, ... )
#endif




#pragma mark - 颜色

#define App_Black0  hexColor(@"0F0D0D")
#define App_Black1  hexColor(@"1F1F1F")
#define App_Gray0   hexColor(@"505050")
#define App_Gray1   hexColor(@"7A7A7A")
#define App_Gray2   hexColor(@"ACACAC")
#define App_Gray3   hexColor(@"DFDFDE")
#define App_Red0    hexColor(@"F70026")
#define App_Red1    hexColor(@"EF5151")





#pragma mark - 字体

#define Font2 [UIFont systemFontOfSize:2]
#define Font3 [UIFont systemFontOfSize:3]
#define Font4 [UIFont systemFontOfSize:4]
#define Font5 [UIFont systemFontOfSize:5]
#define Font6 [UIFont systemFontOfSize:6]
#define Font7 [UIFont systemFontOfSize:7]
#define Font8 [UIFont systemFontOfSize:8]
#define Font9 [UIFont systemFontOfSize:9]
#define Font10 [UIFont systemFontOfSize:10]
#define Font11 [UIFont systemFontOfSize:11]
#define Font12 [UIFont systemFontOfSize:12]
#define Font13 [UIFont systemFontOfSize:13]
#define Font14 [UIFont systemFontOfSize:14]
#define Font15 [UIFont systemFontOfSize:15]
#define Font16 [UIFont systemFontOfSize:16]
#define Font17 [UIFont systemFontOfSize:17]
#define Font18 [UIFont systemFontOfSize:18]
#define Font19 [UIFont systemFontOfSize:19]
#define Font20 [UIFont systemFontOfSize:20]
#define Font21 [UIFont systemFontOfSize:21]
#define Font22 [UIFont systemFontOfSize:22]
#define Font23 [UIFont systemFontOfSize:23]
#define Font24 [UIFont systemFontOfSize:24]





#pragma mark - 设备相关属性

#define MainScreen_Width ([UIScreen mainScreen].bounds.size.width)
#define MainScreen_Height ([UIScreen mainScreen].bounds.size.height)




#pragma mark - 地址

#endif /* AppMacro_h */
