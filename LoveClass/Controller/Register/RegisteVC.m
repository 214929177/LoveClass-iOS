//
//  RegisteVC.m
//  LoveClass
//
//  Created by apple on 16/9/19.
//  Copyright © 2016年 cyfuer. All rights reserved.
//

#import "MainVC.h"
#import "RegisteVC.h"
#import "ImgTextField.h"
#import "UIView+extra.h"
#import "NSString+extra.h"
#import "VertifyCodeButton.h"
#import "UITextField+extra.h"

@interface RegisteVC ()

@property (weak, nonatomic) IBOutlet ImgTextField *phoneTF;
@property (weak, nonatomic) IBOutlet ImgTextField *codeTF;
@property (weak, nonatomic) IBOutlet ImgTextField *pwdTF;

@end

@implementation RegisteVC

#pragma mark - Initialize
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTF];
}

- (void)setupNav {
    [self setBackBtn];
    [self setTitle:@"注册"];
}

- (void)setupTF {
    [self.phoneTF setLeftImg:[UIImage imageNamed:@"phone"]];
    [self.phoneTF setPlaceholderColor:App_Gray0];
    
    
    [self.codeTF setLeftImg:[UIImage imageNamed:@"code"]];
    VertifyCodeButton *codeBtn = [[VertifyCodeButton alloc] initWithFrame:CGRectMake(0, 0, 80, 25)];
    codeBtn.layer.cornerRadius = 12;
    codeBtn.getCodeAction = ^(VertifyCodeButton *btn) {
        
        NSString *phone = self.phoneTF.text;
        if (isEmpty(phone)) {
            [DFHud showMessageHud:@"请输入用户名称"];
        } else if (![phone isMobileNumber]) {
            [DFHud showMessageHud:@"请输入正确的手机号"];
        } else {
            btn.status = GettingCode;
            [self requestForGetCodeWithPhone:phone btn:btn];
        }
    };
    
    self.codeTF.rightView = codeBtn;
    self.codeTF.rightViewMode = UITextFieldViewModeAlways;
    [self.codeTF setPlaceholderColor:App_Gray0];
    
    [self.pwdTF setLeftImg:[UIImage imageNamed:@"pwd"]];
    [self.pwdTF setPlaceholderColor:App_Gray0];
}

#pragma mark - Private
- (IBAction)registeBtnAction:(id)sender {
    [self requestForRegisteWithPhone:self.phoneTF.text code:self.codeTF.text pwd:self.pwdTF.text];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - HTTP
- (void)requestForGetCodeWithPhone:(NSString *)phone btn:(VertifyCodeButton *)btn {
    [DFHud showActivityHud];
    [HYBNetworking postWithUrl:HTTP_GetVerificationCode
                  refreshCache:NO
                        params:@{@"type":@"REGISTER",
                                 @"phone":phone}
                       success:^(id response){
                           [DFHud hide];
                           
                           NSString *state = response[@"errorCode"];
                           if ([state integerValue] == 0) {
                               btn.status = GettedCode;
                           } else {
                               btn.status = ReadyToGetCode;
                               [DFHud showMessageHud:response[@"message"]];
                           }
                       }
                          fail:^(NSError *error){
                              [DFHud hide];
                              btn.status = ReadyToGetCode;
                          }];
}

- (void)requestForRegisteWithPhone:(NSString *)phone code:(NSString *)code pwd:(NSString *)pwd {
    if (isEmpty(phone)) {
        [DFHud showMessageHud:@"请输入手机号"];
    } else if (![phone isMobileNumber]) {
        [DFHud showMessageHud:@"请输入正确的手机号"];
    } else if (isEmpty(code) || code.length != 6) {
        [DFHud showMessageHud:@"请输入6位数的验证码"];
    } else if (isEmpty(pwd) || pwd.length < 6) {
        [DFHud showMessageHud:@"请输入至少6位数的密码"];
    } else {
        [HYBNetworking postWithUrl:HTTP_Register
                      refreshCache:NO
                            params:@{@"verificationCode":code,
                                     @"phone":phone,
                                     @"password":[pwd stringFromMD5]}
                           success:^(id response){
                               [DFHud hide];
                               
                               NSString *state = response[@"errorCode"];
                               if ([state integerValue] == 0) {
                                   User *user = [User yy_modelWithDictionary:response[@"data"]];
                                   [User save:user];
                                   
                                   [self.navigationController popViewControllerAnimated:YES];
                               } else {
                                   [DFHud showMessageHud:response[@"message"]];
                               }
                           }
                              fail:^(NSError *error){
                                  [DFHud hide];
                              }];
    }
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
