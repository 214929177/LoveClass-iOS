//
//  NextFindPasswordVC.m
//  LoveClass
//
//  Created by apple on 16/9/19.
//  Copyright © 2016年 cyfuer. All rights reserved.
//

#import "NextFindPasswordVC.h"
#import "ImgTextField.h"
#import "UITextField+extra.h"

@interface NextFindPasswordVC ()
@property (weak, nonatomic) IBOutlet ImgTextField *pwdTF;
@property (weak, nonatomic) IBOutlet ImgTextField *vertifyCodeTF;

@end

@implementation NextFindPasswordVC

#pragma mark - Initialize
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTF];
}

- (void)setupNav {
    [self setBackBtn];
    [self setTitle:@"忘记密码"];
}

- (void)setupTF {
    [self.pwdTF setLeftImg:[UIImage imageNamed:@"code"]];
    [self.pwdTF setPlaceholderColor:App_Gray0];
    
    [self.vertifyCodeTF setLeftImg:[UIImage imageNamed:@"vertifyCode"]];
    [self.vertifyCodeTF setPlaceholderColor:App_Gray0];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
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
