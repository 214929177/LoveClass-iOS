//
//  TeachersVC.m
//  LoveClass
//
//  Created by Cyfuer on 16/9/25.
//  Copyright © 2016年 cyfuer. All rights reserved.
//

#import "TeachersVC.h"
#import "TeacherRankCell.h"

@interface TeachersVC ()
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation TeachersVC


#pragma mark - Initialize
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setupNav {
    self.title = @"优质导师";
    [self setBackBtn];
}

- (void)setupTalbe {
    
    [self.table registerNib:[UINib nibWithNibName:@"TeacherRankCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"TeacherRankCell"];
}

#pragma mark - UITableViewDataSource && UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;//tableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TeacherRankCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TeacherRankCell"];
    
//    if (tableData.count > indexPath.section) {
//        //cell.item = tableData[indexPath.section];
//    }
    return cell;
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
