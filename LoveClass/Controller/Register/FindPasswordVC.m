//
//  FindPasswordVC.m
//  LoveClass
//
//  Created by apple on 16/9/19.
//  Copyright © 2016年 cyfuer. All rights reserved.
//

#import "FindPasswordVC.h"
#import "ImgTextField.h"
#import "VertifyCodeButton.h"
#import "UITextField+extra.h"

@interface FindPasswordVC () {
    VertifyCodeButton *codeBtn;
}


@property (weak, nonatomic) IBOutlet ImgTextField *phoneTF;
@property (weak, nonatomic) IBOutlet ImgTextField *codeTF;

@end

@implementation FindPasswordVC

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
    [self.phoneTF setLeftImg:[UIImage imageNamed:@"phone"]];
    [self.phoneTF setPlaceholderColor:App_Gray0];
    
    
    [self.codeTF setLeftImg:[UIImage imageNamed:@"code"]];
    codeBtn = [[VertifyCodeButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    self.codeTF.rightView = codeBtn;
    self.codeTF.rightViewMode = UITextFieldViewModeAlways;
    [self.codeTF setPlaceholderColor:App_Gray0];
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
