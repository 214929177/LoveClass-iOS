//
//  VertifyCodeButton.h
//  UIKit-set
//
//  Created by apple on 16/8/18.
//  Copyright © 2016年 Cyfuer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^getCodeAction)(id);

typedef NS_ENUM(NSInteger, VertifyCodeButtonStatus) {
    
    ReadyToGetCode = 0, // 准备获取状态，开始获取验证码时将按钮状态手动设置为GettingCode
    GettingCode,// 正在获取状态，获取验证码成功后把按钮状态手动设置为GettedCode，此状态按钮不可交互
    GettedCode // 成功获取状态，该状态自动进入倒计时，按钮不可交互,倒计时结束自动切换至 ReadyToGetCode
};

@interface VertifyCodeButton : UIButton


@property (assign, nonatomic) NSInteger timeInterval;// 倒计时时间，默认60s

@property (assign, nonatomic) VertifyCodeButtonStatus status;//倒计时按钮状态，默认ReadyToGetCode

@property (strong, nonatomic) getCodeAction getCodeAction;// 按钮处于获取验证码或重新获取验证码状态时点击会调用

@end
