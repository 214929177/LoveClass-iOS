//
//  DFSegmentView.m
//  LoveClass
//
//  Created by apple on 16/9/28.
//  Copyright © 2016年 cyfuer. All rights reserved.
//

#import "DFSegmentView.h"
#import "DFSegmentButton.h"

@implementation DFSegmentView

#pragma mark - Initialize

#pragma mark @ 用代码初始化时通过该方法初始化
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

#pragma mark @ 用Xib初始化时通过该方法初始化
- (void)awakeFromNib {
    [super awakeFromNib];
}

#pragma mark - Private
- (void)action:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(dfSegmentView:didSelectedButtonAtIndex:)]) {
        [self.delegate dfSegmentView:self didSelectedButtonAtIndex:sender.tag];
    }
}

#pragma mark - Setter
- (void)setButtonTitles:(NSArray<NSString *> *)buttonTitles {
    if (buttonTitles && buttonTitles.count) {
        CGFloat w = self.bounds.size.width / buttonTitles.count;
        CGFloat h = self.bounds.size.height;
        
        for (int i = 0; i < buttonTitles.count; i ++) {
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(w * i, 0, w, h)];
            button.tag = i;
            [button addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
