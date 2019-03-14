//
//  FindActionCell.m
//  LoveClass
//
//  Created by apple on 16/8/30.
//  Copyright © 2016年 cyfuer. All rights reserved.
//

#import "FindActionCell.h"
#import "UIImageView+WebCache.h"

@interface FindActionCell ()
@property (weak, nonatomic) IBOutlet UIImageView *img;

@property (weak, nonatomic) IBOutlet UILabel *lab;

@end

@implementation FindActionCell

- (void)setAction:(Action *)action {
    _action = action;
    
    [_img sd_setImageWithURL:url(action.imgUrl) placeholderImage:[UIImage imageNamed:@"defaultImage"]];
    [_lab setText:action.title];
}

@end
