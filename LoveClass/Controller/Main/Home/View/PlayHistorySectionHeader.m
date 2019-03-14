//
//  PlayHistorySectionHeader.m
//  LoveClass
//
//  Created by apple on 16/9/22.
//  Copyright © 2016年 cyfuer. All rights reserved.
//

#import "PlayHistorySectionHeader.h"

@interface PlayHistorySectionHeader ()

@property (weak, nonatomic) IBOutlet UILabel *lab;

@end

@implementation PlayHistorySectionHeader


- (void)setItem:(PlayHistoryItem *)item {
    _item = item;
    self.lab.text = timeStrByDate(item.date, @"yyyy-MM-dd");
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
