//
//  TeacherDetail.m
//  LoveClass
//
//  Created by apple on 16/9/28.
//  Copyright © 2016年 cyfuer. All rights reserved.
//

#import "TeacherDetail.h"
#import "FindVideoCell.h"

@interface TeacherDetail ()
@property (strong, nonatomic) UIView *tableHeader;
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation TeacherDetail
#pragma mark - Initialize
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTable];
}

- (void)setupTable {
    [self.table setTableHeaderView:self.tableHeader];
    [self.table registerNib:[UINib nibWithNibName:@"FindVideoCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"FindVideoCell"];
}

#pragma mark - UITableViewDataSource && UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FindVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FindVideoCell"];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (UIView *)tableHeader {
    UIView *v = [[NSBundle mainBundle] loadNibNamed:@"TeacherDetailTableHeader" owner:self options:nil][0];
    return v;
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
