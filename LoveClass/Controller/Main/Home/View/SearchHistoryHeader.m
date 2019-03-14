//
//  SearchHistoryHeader.m
//  LoveClass
//
//  Created by apple on 16/10/19.
//  Copyright © 2016年 cyfuer. All rights reserved.
//

#import "SearchHistoryHeader.h"

@implementation SearchHistoryHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)clearBtnAction:(id)sender {
    if (self.clearAction) {
        self.clearAction();
    }
}
@end
