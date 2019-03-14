//
//  BaseVC.m
//  LoveClass
//
//  Created by apple on 16/8/29.
//  Copyright © 2016年 cyfuer. All rights reserved.
//

#import "BaseVC.h"

float const nav_barItem_horizontalSpacing = 16;
float const nav_barItem_horizontalMargin  = -16;
float const nav_barItem_buttonFont = 16;
float const nav_barItem_titleFont = 16;

@interface BaseVC ()

@end

@implementation BaseVC

#pragma mark - Intialize
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.hidesBottomBarWhenPushed = YES;
//        self.navigationItem.hidesBackButton =YES;
        // 隐藏系统的导航栏返回按钮，因为没有设置任何左侧item，所以默认返回按钮还在
        self.navigationItem.hidesBackButton = YES;
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:nil];
        self.navigationItem.backBarButtonItem = backItem;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavbgColor:[UIColor colorWithRed:0.06 green:0.05 blue:0.05 alpha:1.00]];
    
    [self setupNav];
}

#pragma mark  -  导航栏 (7.0~9.3)

- (void)setupNav {
    
}

- (void)hideNav {
    if (!self.navigationController.navigationBarHidden) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
}

- (void)showNav {
    if (self.navigationController.navigationBarHidden) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}

- (void)setBackBtn {
    
    // 显示导航栏
    [self showNav];
    
    // 填充块，让按钮贴近左侧
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width =  nav_barItem_horizontalMargin;
    
    UIButton *backBtn = [[UIButton alloc]init];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    backBtn.imageView.contentMode = UIViewContentModeCenter;
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    [self.navigationItem setLeftBarButtonItems:@[negativeSpacer,backItem] animated:YES];
}

// 通过名称自定义单个按钮
- (UIButton *)setLeftNavBarItemWithTitle:(NSString *)title action:(SEL)action {
    
    if (title && ![title isEqual:[NSNull null]] && title.length) {
        // 显示导航栏
        [self showNav];
        
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacer.width = nav_barItem_horizontalMargin;
        
        UIButton *button = [self getNavButtonWithString:title sel:action];
        
        UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:button];
        
        [self.navigationItem setLeftBarButtonItems:@[negativeSpacer,barItem] animated:YES];
        
        return button;
    }
    else {
        return nil;
    }
}

- (UIButton *)setLeftNavBarItemWithImage:(UIImage *)image action:(SEL)action {
    if (image) {
        // 显示导航栏
        [self showNav];
        
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacer.width = nav_barItem_horizontalMargin;
        
        UIButton *button = [self getNavButtonWithImage:image sel:action];
        
        UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:button];
        
        [self.navigationItem setLeftBarButtonItems:@[negativeSpacer,barItem] animated:YES];
        
        return button;
    }
    else {
        return nil;
    }
}

// 通过自定义视图定义单个按钮
- (UIView *)setLeftNavBarItemWithView:(UIView *)view {
    if (view) {
        // 显示导航栏
        [self showNav];
        
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacer.width = nav_barItem_horizontalMargin;
        
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
        
        [self.navigationItem setLeftBarButtonItems:@[negativeSpacer,barButtonItem] animated:YES];
        
        return view;
    }
    return nil;
}

// 通过自定义视图数组定义多个按钮
- (NSArray *)setLeftNavBarItemsWithViews:(NSArray *)views {
    if (views && views.count) {
        // 显示导航栏
        [self showNav];
        
        // 生成barButtonItem数组
        NSMutableArray *barButtonItems = [NSMutableArray array];
        
        for (UIView *view in views) {
            if (barButtonItems.count) {
                UIBarButtonItem *spaceBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
                spaceBarButtonItem.width = nav_barItem_horizontalSpacing;
                [barButtonItems addObject:spaceBarButtonItem];
            }
            else {
                UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                                   initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                   target:nil action:nil];
                negativeSpacer.width = nav_barItem_horizontalMargin;
                [barButtonItems addObject:negativeSpacer];
            }
            
            UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:view];
            [barButtonItems addObject:barButtonItem];
        }
        
        // 添入navgationItem
        [self.navigationItem setLeftBarButtonItems:barButtonItems animated:YES];
        
        return views;
    }
    return nil;
}

// 通过名称自定义单个按钮
- (UIButton *)setRightNavBarItemWithTitle:(NSString *)title action:(SEL)action {
    if (title && ![title isEqual:[NSNull null]] && title.length) {
        // 显示导航栏
        [self showNav];
        
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacer.width = nav_barItem_horizontalMargin;
        
        UIButton *button = [self getNavButtonWithString:title sel:action];
        
        UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:button];
        
        [self.navigationItem setRightBarButtonItems:@[negativeSpacer,barItem] animated:YES];
        
        return button;
    }
    else {
        return nil;
    }
}

- (UIButton *)setRightNavBarItemWithImage:(UIImage *)image action:(SEL)action {
    if (image) {
        // 显示导航栏
        [self showNav];
        
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacer.width = nav_barItem_horizontalMargin;
        
        UIButton *button = [self getNavButtonWithImage:image sel:action];
        
        UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:button];
        
        [self.navigationItem setRightBarButtonItems:@[negativeSpacer,barItem] animated:YES];
        
        return button;
    }
    else {
        return nil;
    }
}

// 通过自定义视图定义单个按钮
- (UIView *)setRightNavBarItemWithView:(UIView *)view {
    if (view) {
        // 显示导航栏
        [self showNav];
        
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacer.width = nav_barItem_horizontalMargin;
        
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
        
        [self.navigationItem setRightBarButtonItems:@[negativeSpacer,barButtonItem] animated:YES];
        
        return view;
    }
    return nil;
}

// 通过自定义视图数组定义多个按钮
- (NSArray *)setRightNavBarItemsWithViews:(NSArray *)views {
    if (views && views.count) {
        // 显示导航栏
        [self showNav];
        
        
        // 生成barButtonItem数组
        NSMutableArray *barButtonItems = [NSMutableArray array];
        
        for (UIView *view in views) {
            if (barButtonItems.count) {
                UIBarButtonItem *spaceBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
                spaceBarButtonItem.width = nav_barItem_horizontalSpacing;
                [barButtonItems addObject:spaceBarButtonItem];
            }
            else {
                UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                                   initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                   target:nil action:nil];
                negativeSpacer.width = nav_barItem_horizontalMargin;
                [barButtonItems addObject:negativeSpacer];
            }
            
            UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:view];
            [barButtonItems addObject:barButtonItem];
        }
        
        // 添入navgationItem
        [self.navigationItem setRightBarButtonItems:barButtonItems animated:YES];
        
        return views;
    }
    return nil;
}

// 自定义titleView
- (UIView *)setNavBarTitleViewWithView:(UIView *)view {
    if (view) {
        // 显示导航栏
        [self showNav];
        
        self.navigationItem.titleView = view;
        
        return view;
    }
    return nil;
}

- (UIButton *)getNavButtonWithString:(NSString *)string sel:(SEL)selector {
    UIFont* titleFont = [UIFont systemFontOfSize:nav_barItem_titleFont];
    CGSize requestedTitleSize = [string sizeWithFont:titleFont];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, requestedTitleSize.width, 44)];
    
    button.titleLabel.font = [UIFont systemFontOfSize:nav_barItem_titleFont];
    
    [button setTitle:string forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateDisabled];
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [button setAdjustsImageWhenHighlighted:NO];
    
    return button;
}

- (UIButton *)getNavButtonWithImage:(UIImage *)image sel:(SEL)selector {
    CGRect rect = CGRectZero;
    rect.size = image.size;
    
    UIButton *button = [[UIButton alloc] initWithFrame:rect];
    [button setImage:image forState:UIControlStateNormal];
    [button setAdjustsImageWhenHighlighted:NO];
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setNavbgColor:(UIColor *)color {
    self.navigationController.navigationBar.barTintColor = color;
    self.navigationController.navigationBar.translucent = NO;
}


@end
