//
//  MoreVideoVC.m
//  LoveClass
//
//  Created by apple on 16/10/24.
//  Copyright © 2016年 cyfuer. All rights reserved.
//

#import "MoreVideoVC.h"
#import "MoreVideoVC.h"
#import "MoreVideoCell.h"
#import "Series.h"
#import "VideoVC.h"

@interface MoreVideoVC () {
    NSArray <Series *>*videos;
}
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation MoreVideoVC

#pragma mark - Initialize
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTable];
}

- (void)setupTable {
    self.table.rowHeight = 88;
    [self.table registerNib:[UINib nibWithNibName:@"MoreVideoCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MoreVideoCell"];
}

#pragma mark - UITableViewDataSource && UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return videos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MoreVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MoreVideoCell"];
    
    if (videos.count > indexPath.section) {
        
        cell.series = videos[indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Series *s = videos[indexPath.row];
    VideoVC *vc = [[VideoVC alloc] init];
    vc.seriesId = s.Id;
    [self.navigationController pushViewController:vc animated:YES];
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
