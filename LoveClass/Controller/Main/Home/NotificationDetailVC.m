//
//  NotificationDetailVC.m
//  LoveClass
//
//  Created by apple on 16/9/28.
//  Copyright © 2016年 cyfuer. All rights reserved.
//

#import "NotificationDetailVC.h"

@interface NotificationDetailVC ()
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;

@end

@implementation NotificationDetailVC

#pragma mark - Initialize
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)setupNav {
    [self setBackBtn];
}

- (void)setupView {
    self.titleLab.text = self.notify.title;
    self.contentLab.text = self.notify.message;
    self.timeLab.text = self.notify.createTime;
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
