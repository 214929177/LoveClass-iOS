//
//  LoginVC.m
//  LoveClass
//
//  Created by apple on 16/9/19.
//  Copyright © 2016年 cyfuer. All rights reserved.
//

#import "LoginVC.h"
#import "UITextField+extra.h"
#import "UIColor+extra.h"
#import "UIView+extra.h"
#import "NSString+extra.h"
#import "MainVC.h"

@interface LoginVC ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;

@end

@implementation LoginVC

#pragma mark - Initialize
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTF];
}

- (void)setupTF {
    [self.phoneTF setPlaceholderColor:hexColor(@"acacac")];
    [self.pwdTF setPlaceholderColor:hexColor(@"acacac")];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.phoneTF.text = @"13794263325";
    self.pwdTF.text = @"263325";
    if (!isEmpty([User loadUser].account)) {
        self.phoneTF.text = [User loadUser].account;
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self hideNav];
}

#pragma mark - Private
- (IBAction)login:(id)sender {
    if (isEmpty(self.phoneTF.text)) {
        [DFHud showMessageHud:@"请输入手机号/Email"];
    } else if (![self.phoneTF.text isMobileNumber]) {
        [DFHud showMessageHud:@"请输入正确的手机号"];
    } else if (isEmpty(self.pwdTF.text) || self.pwdTF.text.length < 6) {
        [DFHud showMessageHud:@"密码至少6位"];
    } else {
        [self requestForLoginWithName:self.phoneTF.text pwd:self.pwdTF.text];
    }
}
- (IBAction)closeBtnAction:(id)sender {
    MainVC *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MainVC"];
    [UIApplication sharedApplication].delegate.window.rootViewController = vc;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - HTTP
- (void)requestForLoginWithName:(NSString *)name pwd:(NSString *)pwd {
    [DFHud showActivityHud];
    [HYBNetworking postWithUrl:HTTP_Login
                  refreshCache:NO
                        params:@{@"account":name,
                                 @"password":[pwd stringFromMD5]}
                       success:^(id response){
                           [DFHud hide];
                           
                           NSString *state = response[@"errorCode"];
                           if ([state  integerValue] == 0) {
                               User *user = [User yy_modelWithDictionary:response[@"data"]];
                               user.pwd = pwd;
                               user.isLogin = YES;
                               [User save:user];
                               
                               MainVC *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MainVC"];
                               [UIApplication sharedApplication].delegate.window.rootViewController = vc;
                           } else {
                               [DFHud showMessageHud:response[@"message"]];
                           }
                       }
                          fail:^(NSError *error){
                              [DFHud hide];
                          }];
    
    [HYBNetworking postWithUrl:@"http://mall.iflashbuy.com/iflashbuy/rest/queryform/"
                  refreshCache:NO
                        params:@{@"identify":name,
                                 @"loginPwd":pwd,
                                 @"method":@"login"}
                       success:^(id response){
                           [DFHud hide];
                           
                           NSString *state = response[@"errorCode"];
                           if ([state  integerValue] == 0) {
                               
                           } else {
                               [DFHud showMessageHud:response[@"message"]];
                           }
                       }
                          fail:^(NSError *error){
                              [DFHud hide];
                          }];
}

@end
