//
//  User.h
//  HealthMonitor
//  账户信息
//  Created by Cyfuer on 15-1-23.
//  Copyright (c) 2015年 Rworld. All rights reserved.
//

#import <Foundation/Foundation.h>

#define user_app ([User sharedInstance])

@interface User : NSObject

@property (copy ,nonatomic) NSString *uid;// 客户id

@property (copy ,nonatomic) NSString *account;// 账户

@property (copy ,nonatomic) NSString *pwd;// 账户密码

@property (copy ,nonatomic) NSString *nickname;// 客户名称

@property (copy ,nonatomic) NSString *phone;// 手机号

@property (copy ,nonatomic) NSString *virtualMoney;// 金钱

@property (copy ,nonatomic) NSString *portraitUrl;

@property (copy ,nonatomic) NSString *Description;// 签名

@property (assign, nonatomic) BOOL isLogin;


@property (copy ,nonatomic) NSArray *notifies;// 通知列表
@property (assign ,nonatomic) NSInteger maxId;// 本地存储的最新通知的Id，下次获取新通知的时候用该值获取

@property (copy, nonatomic) NSArray *searchHistories;// 搜索纪录

@property (copy, nonatomic) NSArray *playHistories;// 播放纪录

// 保持模型
+ (void)save:(User *)user;

// 读取模型
+ (User *)loadUser;

// 删除模型
+ (void)deleteUser;

@end
