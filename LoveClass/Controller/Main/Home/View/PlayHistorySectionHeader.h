//
//  PlayHistorySectionHeader.h
//  LoveClass
//
//  Created by apple on 16/9/22.
//  Copyright © 2016年 cyfuer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayHistoryItem.h"

@interface PlayHistorySectionHeader : UIView

@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (strong, nonatomic) PlayHistoryItem *item;

@end
