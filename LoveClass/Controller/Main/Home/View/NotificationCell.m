//
//  NotificationCell.m
//  LoveClass
//
//  Created by apple on 16/9/23.
//  Copyright © 2016年 cyfuer. All rights reserved.
//

#import "NotificationCell.h"

@interface NotificationCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;


@end

@implementation NotificationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setNotify:(Notify *)notify {
    _notify = notify;
    
    _titleLab.text = notify.title;
    _contentLab.text = notify.message;
    _timeLab.text = notify.createTime;
}

@end

