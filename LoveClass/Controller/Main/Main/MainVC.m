//
//  MainVC.m
//  LoveClass
//
//  Created by apple on 16/9/19.
//  Copyright © 2016年 cyfuer. All rights reserved.
//

#import "MainVC.h"
#import "UIColor+extra.h"

@interface MainVC ()

@end

@implementation MainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTabbarItem];
}

- (void)setupTabbarItem {
    self.tabBar.barTintColor = [UIColor whiteColor];
    
    UITabBar *tabbar = [UITabBar appearance];
    tabbar.tintColor = hexColor(@"1F1F1F");// 设置选中的颜色
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:hexColor(@"ACACAC")} forState:UIControlStateNormal];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:hexColor(@"1F1F1F")} forState:UIControlStateSelected];
    [item setTitlePositionAdjustment:UIOffsetMake(0, -3)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
