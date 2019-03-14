//
//  PlayHistoryVC.m
//  LoveClass
//
//  Created by apple on 16/9/22.
//  Copyright © 2016年 cyfuer. All rights reserved.
//

#import "PlayHistoryVC.h"
#import "PlayHistoryCell.h"
#import "PlayHistorySectionHeader.h"
#import "PlayHistoryItem.h"

@interface PlayHistoryVC () {
    NSArray *tableData;
}

@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation PlayHistoryVC

#pragma mark - Initialize
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([User loadUser].isLogin) {
        tableData = [User loadUser].playHistories;
    }
    
    [self setupTalbe];
}

- (void)setupNav {
    self.title = @"播放历史";
    [self setBackBtn];
}

- (void)setupTalbe {

    [self.table registerNib:[UINib nibWithNibName:@"PlayHistoryCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"PlayHistoryCell"];
    [self.table reloadData];
}

#pragma mark - UITableViewDataSource && UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return tableData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    PlayHistoryItem *item = tableData[section];
    return item.videos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PlayHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlayHistoryCell"];
    
    if (tableData.count > indexPath.section) {
        PlayHistoryItem *item = tableData[indexPath.section];
        cell.video = item.videos[indexPath.row];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    PlayHistorySectionHeader *view = [[NSBundle mainBundle] loadNibNamed:@"PlayHistorySectionHeader" owner:self options:nil][0];
    view.frame = CGRectMake(0, 0, MainScreen_Width, 50);
    view.item = tableData[section];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
