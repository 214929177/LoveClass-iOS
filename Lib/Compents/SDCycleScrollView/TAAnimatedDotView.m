//
//  TAAnimatedDotView.m
//  TAPageControl
//
//  Created by Tanguy Aladenise on 2015-01-22.
//  Copyright (c) 2015 Tanguy Aladenise. All rights reserved.
//

#import "TAAnimatedDotView.h"

static CGFloat const kAnimateDuration = 1;

@implementation TAAnimatedDotView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialization];
    }
    
    return self;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialization];
    }
    return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialization];
    }
    
    return self;
}


- (void)initialization
{
    self.backgroundColor = [UIColor colorWithRed:0.33 green:0.57 blue:0.97 alpha:1.00];
    self.alpha = 0.2;
//    self.layer.cornerRadius = CGRectGetWidth(self.frame) / 2;
    //self.layer.borderColor  = [UIColor colorWithRed:0.33 green:0.57 blue:0.97 alpha:1.00].CGColor;
    //self.alpha = 0.2;
    //self.layer.borderWidth  = 1;
    self.backgroundColor = [UIColor colorWithRed:0.33 green:0.57 blue:0.97 alpha:1.00];
}


- (void)changeActivityState:(BOOL)active
{
    if (active) {
        [self animateToActiveState];
    } else {
        [self animateToDeactiveState];
    }
}


- (void)animateToActiveState
{
    [UIView animateWithDuration:kAnimateDuration delay:0 usingSpringWithDamping:.5 initialSpringVelocity:-20 options:UIViewAnimationOptionCurveLinear animations:^{
        //self.backgroundColor = [UIColor whiteColor];
        self.alpha = 1;
        //self.transform = CGAffineTransformMakeScale(1.4, 1.4);
    } completion:nil];
}

- (void)animateToDeactiveState
{
    [UIView animateWithDuration:kAnimateDuration delay:0 usingSpringWithDamping:.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.alpha = 0.2;
        //self.backgroundColor = [UIColor clearColor];
        //self.transform = CGAffineTransformIdentity;
    } completion:nil];
}

@end
