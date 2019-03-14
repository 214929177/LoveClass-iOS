//
//  MineVC.m
//  LoveClass
//
//  Created by Cyfuer on 16/8/29.
//  Copyright © 2016年 cyfuer. All rights reserved.
//

#import "MineVC.h"
#import "MineCell.h"
#import "MineTopView.h"
#import "UIImageView+WebCache.h"

#import "LoginVC.h"
#import "LCNavigationController.h"
#import "UserInfoVC.h"

@interface MineVC () {
    NSArray *tableData;
}

@property (strong, nonatomic) UIView *tableHeader;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UIButton *loginbtn;

@end

@implementation MineVC

#pragma mark - Intialize
- (void)viewDidLoad {
    [super viewDidLoad];
    
    tableData = @[@[@"关注的导师",@"离线缓存",@"VIP购买"],
                  @[@"意见反馈",@"商务合作"],
                  @[@"退出登录"]];
    
    [self setupTable];
}

- (void)setupNav {
    self.title = @"我的";
}

- (void)setupTable {
    self.table.tableHeaderView.userInteractionEnabled = YES;
    [self.table setTableHeaderView:self.tableHeader];
    [self.table registerNib:[UINib nibWithNibName:@"MineCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MineCell"];
    [self.table reloadData];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.loginbtn.hidden = [User loadUser].isLogin;
    self.table.hidden = ![User loadUser].isLogin;
    [self updateUserInfo];
}

#pragma mark - Private
- (void)logout {
    LoginVC *vc = [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateViewControllerWithIdentifier:@"LoginVC"];
    LCNavigationController *nav = [[LCNavigationController alloc] initWithRootViewController:vc];
    [UIApplication sharedApplication].delegate.window.rootViewController = nav;
    
    [self clearUser];
}

- (void)clearUser {
    User *user = [User loadUser];
    user.isLogin = NO;
    [User save:user];
}
- (IBAction)loginBtnAction:(id)sender {
    LoginVC *vc = [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateViewControllerWithIdentifier:@"LoginVC"];
    LCNavigationController *nav = [[LCNavigationController alloc] initWithRootViewController:vc];
    [UIApplication sharedApplication].delegate.window.rootViewController = nav;
}

- (void)updateUserInfo {
    MineTopView *v = (MineTopView *)self.table.tableHeaderView;
    v.nameLab.text = [User loadUser].nickname;
    [v.avatarImg sd_setImageWithURL:url([User loadUser].portraitUrl) placeholderImage:[UIImage imageNamed:@"defaultImage"]];
}

#pragma mark - UITableViewDataSource && UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return tableData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = tableData[section];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineCell"];
    
    NSArray *array = tableData[indexPath.section];
    cell.lab.text = array[indexPath.row];
    cell.separatorLine.hidden = (indexPath.row == array.count);
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainScreen_Width, 10)];
    v.backgroundColor = hexColor(@"f2f2f2");
    return v;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *section = tableData[indexPath.section];
    NSString *title = section[indexPath.row];
    
    if ([title isEqualToString:@""]) {
        
    } else if ([title isEqualToString:@"退出登录"]) {
        [DFHud showAlertView:@"温馨提示" msg:@"确定要退出登录吗?" completionBlock:^(NSUInteger buttonIndex, DFAlertView *alertView) {
            if (buttonIndex == 0) {
                [self requestForLogout];
            }
        } cancelBtnTitle:@"确定" otherButtonTitles:@"取消",nil];
    }
}

#pragma mark - Getter
- (UIView *)tableHeader {
    if (!_tableHeader) {
        MineTopView *v = [[NSBundle mainBundle] loadNibNamed:@"MineTopView" owner:self options:nil][0];
        v.nameLab.text = [User loadUser].nickname;
        [v.avatarImg sd_setImageWithURL:url([User loadUser].portraitUrl) placeholderImage:[UIImage imageNamed:@"defaultImage"]];
        [v.bgBtn addTarget:self action:@selector(bgBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [v.playHistoryBtn addTarget:self action:@selector(historyBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [v.myFavorBtn addTarget:self action:@selector(favorBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [v.myTipBtn addTarget:self action:@selector(tipBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [v.myMessageBtn addTarget:self action:@selector(messageBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [v setAutoresizingMask:UIViewAutoresizingNone];
        
        _tableHeader = v;
    }
    return _tableHeader;
}

- (void)bgBtnAction {
    UserInfoVC *vc = [[UserInfoVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)historyBtnAction {
    NSLog(@".......");
}
- (void)favorBtnAction {
    NSLog(@".......");
}
- (void)tipBtnAction {
    NSLog(@".......");
}
- (void)messageBtnAction {
    NSLog(@".......");
}


#pragma mark - HTTP
- (void)requestForLogout {
    [DFHud showActivityHud];
    [HYBNetworking getWithUrl:HTTP_Logout
                 refreshCache:NO
                       params:nil
                      success:^(id response){
                          [DFHud hide];
                          
                          NSString *state = response[@"errorCode"];
                          
                          if ([state  integerValue] == 0) {
                              [self logout];
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
