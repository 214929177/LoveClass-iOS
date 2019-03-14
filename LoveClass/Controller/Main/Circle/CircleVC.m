//
//  CircleVC.m
//  LoveClass
//
//  Created by Cyfuer on 16/8/29.
//  Copyright © 2016年 cyfuer. All rights reserved.
//

#import "CircleVC.h"
#import "CircleCell.h"

@interface CircleVC ()
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation CircleVC

#pragma mark - Intialize
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setupNav {
    self.title = @"发现";
}

- (void)setupTable {
    self.table.estimatedRowHeight = 200;
    self.table.rowHeight = UITableViewAutomaticDimension;
}

#pragma mark - UITableViewDataSource && UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CircleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CircleCell"];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
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
