//
//  BaseVC.h
//  LoveClass
//
//  Created by apple on 16/8/29.
//  Copyright © 2016年 cyfuer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseVC : UIViewController

#pragma mark - Nav
// 隐藏导航栏
- (void)hideNav;

// 显示导航栏
- (void)showNav;

// 设置自定义的返回按钮
- (void)setBackBtn;


// 左侧：通过名称自定义单个按钮
- (UIButton *)setLeftNavBarItemWithTitle:(NSString *)title action:(SEL)action;

// 左侧：通过图片自定义单个按钮
- (UIButton *)setLeftNavBarItemWithImage:(UIImage *)image action:(SEL)action;

// 左侧：通过自定义视图定义单个按钮
- (UIView *)setLeftNavBarItemWithView:(UIView *)view;

// 左侧：通过自定义视图数组定义多个按钮
- (NSArray *)setLeftNavBarItemsWithViews:(NSArray *)views;


// 右侧：通过名称自定义单个按钮
- (UIButton *)setRightNavBarItemWithTitle:(NSString *)title action:(SEL)action;

// 右侧：通过图片自定义单个按钮
- (UIButton *)setRightNavBarItemWithImage:(UIImage *)image action:(SEL)action;

// 右侧：通过自定义视图定义单个按钮
- (UIView *)setRightNavBarItemWithView:(UIView *)view;

// 右侧：通过自定义视图数组定义多个按钮
- (NSArray *)setRightNavBarItemsWithViews:(NSArray *)views;


// 中间：自定义titleView
- (UIView *)setNavBarTitleViewWithView:(UIView *)view;

@end
