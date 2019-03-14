//
//  UserInfoVC.m
//  LoveClass
//
//  Created by apple on 16/10/17.
//  Copyright © 2016年 cyfuer. All rights reserved.
//

#import "UserInfoVC.h"
#import "UIView+extra.h"
#import "UIViewController+SelectPhotoIcon.h"
#import "UIButton+WebCache.h"

@interface UserInfoVC ()
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *sayingTF;
@property (weak, nonatomic) IBOutlet UIButton *avatarBtn;

@end

@implementation UserInfoVC

#pragma mark - Initialize
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTF];
    
    [self.view addTargetForEndEdit];
}

- (void)setupNav {
    [self setBackBtn];
    self.title = @"用户信息";
}

- (void)setupTF {
    [self.nameTF setLine:UIViewSideBottom Color:[UIColor blackColor]];
    [self.sayingTF setLine:UIViewSideBottom Color:[UIColor blackColor]];
}

- (void)viewWillAppear:(BOOL)animated {
    self.nameTF.text = [User loadUser].nickname;
    self.sayingTF.text = [User loadUser].Description;
    [self.avatarBtn sd_setImageWithURL:url([User loadUser].portraitUrl) forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"defaultImage"]];
}

#pragma mark - Private
- (IBAction)avatarBtnAction:(id)sender {
    [self showActionSheet];
}
- (IBAction)saveBtnAction:(id)sender {
    if (isEmpty(self.nameTF.text)) {
        [DFHud showMessageHud:@"请输入昵称"];
    } else {
        [self requestForUpdateInfoWithName:self.nameTF.text saying:null(self.sayingTF.text, @"")];
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.nameTF) {
        [self.sayingTF becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    return YES;
}

#pragma mark - UIImagePickerControllerDelegate
//TODO:修改头像
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info;{
    
    //获得编辑后的图片
    UIImage *editedImage = (UIImage *)info[UIImagePickerControllerEditedImage];
    [self requestForUploadImage:editedImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - HTTP
- (void)requestForUploadImage:(UIImage *)img {
    [DFHud showActivityHud];
    [HYBNetworking uploadWithImage:img
                               url:HTTP_UploadAvatar
                          filename:@"avatar"
                              name:@"imagefiles"
                          mimeType:@"image/jpeg"
                        parameters:nil
                          progress:^(int64_t bytesWritten, int64_t totalBytesWritten) {
                              
                          }
                           success:^(id response) {
                               [DFHud hide];
                               
                               NSString *state = response[@"errorCode"];
                               if ([state  integerValue] == 0) {
                                   User *u = [User loadUser];
                                   u.portraitUrl = response[@"data"][@"url"];
                                   [self.avatarBtn sd_setImageWithURL:url(response[@"data"][@"url"]) forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"defaultImage"]];
                               } else {
                                   [DFHud showMessageHud:response[@"message"]];
                               }
                           }
                              fail:^(NSError *error) {
                                  [DFHud hide];
                              }];
}

- (void)requestForUpdateInfoWithName:(NSString *)name saying:(NSString *)saying {
    [DFHud showActivityHud];
    [HYBNetworking postWithUrl:HTTP_UpdateUserInfo
                 refreshCache:NO
                       params:@{@"description":saying,
                                @"nickname":name}
                      success:^(id response){
                          [DFHud hide];
                          
                          NSString *state = response[@"errorCode"];
                          if ([state  integerValue] == 0) {
                              [self.navigationController popViewControllerAnimated:YES];
                              User *u = [User loadUser];
                              u.nickname = response[@"data"][@"nickname"];
                              u.Description = response[@"data"][@"description"];
                              [User save:u];
                          } else {
                              [DFHud showMessageHud:response[@"message"]];
                          }
                      }
                         fail:^(NSError *error){
                             [DFHud hide];
                         }];
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
