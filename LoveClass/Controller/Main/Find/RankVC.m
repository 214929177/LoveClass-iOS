//
//  RankVC.m
//  LoveClass
//
//  Created by apple on 16/9/28.
//  Copyright © 2016年 cyfuer. All rights reserved.
//

#import "RankVC.h"
#import "DFSegmentView.h"
#import "FindVideoCell.h"

@interface RankVC () <DFSegmentViewDelegate>
@property (weak, nonatomic) IBOutlet DFSegmentView *segmentView;
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation RankVC

#pragma mark - Initialize
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTable];
    [self setupSegmentView];
}

- (void)setupTable {
    [self.table registerNib:[UINib nibWithNibName:@"FindVideoCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"FindVideoCell"];
}

- (void)setupSegmentView {
    self.segmentView.delegate = self;
    self.segmentView.buttonTitles = [self getButtonTitlesByType:self.type];
}

- (NSArray *)getButtonTitlesByType:(NSInteger)type {
    return nil;
}

- (void)setupNav {
    [self setBackBtn];
    [self setTitle:@""];
}

#pragma mark - DFSegmentViewDelegate
- (void)dfSegmentView:(DFSegmentView *)view didSelectedButtonAtIndex:(NSInteger)tag {
    
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



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
