//
//  MineTopView.m
//  LoveClass
//
//  Created by apple on 16/9/28.
//  Copyright © 2016年 cyfuer. All rights reserved.
//

#import "MineTopView.h"

@implementation MineTopView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setupView];
}
- (IBAction)AAAAA:(id)sender {
    NSLog(@"DFSAF");
}

- (void)setupView {
    self.avatarImg.layer.cornerRadius = 54 / 2;
    self.avatarImg.layer.borderColor = [UIColor whiteColor].CGColor;
    self.avatarImg.layer.borderWidth = 2;
    self.avatarImg.backgroundColor = [UIColor whiteColor];
    self.avatarImg.clipsToBounds = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

@end
