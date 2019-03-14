//
//  ArticleVC.m
//  LoveClass
//
//  Created by apple on 16/9/28.
//  Copyright © 2016年 cyfuer. All rights reserved.
//

#import "ArticleVC.h"
#import "ArticleConmentCell.h"
#import "ArticleContentCell.h"
#import "ArticleTableHeader.h"

@interface ArticleVC ()

@property (strong, nonatomic) UIView *tableHeader;
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation ArticleVC

#pragma mark - Initialize
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTable];
}

- (void)setupTable {
    self.table.estimatedRowHeight = 44;
    self.table.rowHeight = UITableViewAutomaticDimension;
    self.table.tableHeaderView = self.tableHeader;
    [self.table registerNib:[UINib nibWithNibName:@"ArticleConmentCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ArticleConmentCell"];
    [self.table registerNib:[UINib nibWithNibName:@"ArticleContentCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ArticleContentCell"];
}

#pragma mark - UITableViewDataSource && UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 10;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        ArticleContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ArticleContentCell"];
        return cell;
    } else if (indexPath.section == 1) {
        ArticleConmentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ArticleConmentCell"];
        return cell;
    }
    
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    } else if (section == 1) {
        return 10;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return nil;
    } else if (section == 1) {
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainScreen_Width, 10)];
        v.backgroundColor = hexColor(@"e1e1e1");
        return v;
    }
    return  nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - Getter
- (UIView *)tableHeader {
    UIView *v = [[NSBundle mainBundle] loadNibNamed:@"ArticleTableHeader" owner:self options:nil][0];
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
