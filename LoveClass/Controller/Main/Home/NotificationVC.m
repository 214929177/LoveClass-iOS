//
//  NotificationVC.m
//  LoveClass
//
//  Created by apple on 16/9/23.
//  Copyright © 2016年 cyfuer. All rights reserved.
//

#import "NotificationVC.h"
#import "NotificationCell.h"
#import "Notify.h"
#import "NotificationDetailVC.h"
#import "FindVC.h"

@interface NotificationVC () {
    NSMutableArray *tableData;
    NSArray *localNotifies;
}

@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation NotificationVC

#pragma mark - Initialize
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTalbe];
    
    // 获取通知列表，获取过的存在本地，新获取的加本地的组成通知列表
    localNotifies = [User loadUser].notifies;
    [self requestForNotifies:[User loadUser].maxId];
}

- (void)setupNav {
    self.title = @"通知";
    [self setBackBtn];
}

- (void)setupTalbe {
    // 二者缺一不可,需要注意的是不能再实现tableView: heightForRowAtIndexPath:方法了，该方法的优先级更高，会覆盖掉rowHeight。
    self.table.estimatedRowHeight = 94;
    self.table.rowHeight = UITableViewAutomaticDimension;
    [self.table registerNib:[UINib nibWithNibName:@"NotificationCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"NotificationCell"];
    
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor clearColor];
    
    [self.table setTableFooterView:view];
}

#pragma mark - UITableViewDataSource && UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NotificationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NotificationCell"];
    
    if (tableData.count > indexPath.section) {
        
        cell.notify = tableData[indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Notify *n = tableData[indexPath.row];
    [tableData removeObject:n];
    [tableView reloadData];
    
    NotificationDetailVC *vc = [[NotificationDetailVC alloc] init];
    vc.notify = n;
    [self.navigationController pushViewController:vc animated:YES];
    
    User *u = [User loadUser];
    u.notifies = (NSArray *)tableData;
    [User save:u];
}

#pragma mark - HTTP
- (void)requestForNotifies:(NSInteger)maxId {
    [DFHud showActivityHud];
    [HYBNetworking getWithUrl:HTTP_Notifies
                 refreshCache:NO
                       params:@{@"maxId":[NSString stringWithFormat:@"%ld",maxId]}
                      success:^(id response){
                          [DFHud hide];
                          
                          NSString *state = response[@"errorCode"];
                          if ([state integerValue] == 0) {
                              // 新获取的通知
                              NSArray *array = [NSArray yy_modelArrayWithClass:[Notify class] json:response[@"data"]];
                              tableData = [NSMutableArray arrayWithArray:array];
                              
                              if (localNotifies && localNotifies.count) {
                                  
                                  [tableData addObjectsFromArray:localNotifies];
                              }
                              
                              [self.table reloadData];
                              
                              // 缓存通知
                              User *u = [User loadUser];
                              u.notifies = tableData;
                              if (array && array.count) {
                                  Notify *n = array[0];
                                  u.maxId = [n.nid integerValue];
                              }
                              [User save:u];
                          }
                          else {
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
