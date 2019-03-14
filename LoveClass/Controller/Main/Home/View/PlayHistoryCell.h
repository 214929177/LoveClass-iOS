//
//  PlayHistoryCell.h
//  LoveClass
//
//  Created by apple on 16/9/22.
//  Copyright © 2016年 cyfuer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayHistoryItem.h"

@interface PlayHistoryCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (strong, nonatomic) HistoryVideo *video;

@end
