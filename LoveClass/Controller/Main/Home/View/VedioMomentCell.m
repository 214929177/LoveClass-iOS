//
//  VedioMomentCell.m
//  LoveClass
//
//  Created by apple on 16/9/27.
//  Copyright © 2016年 cyfuer. All rights reserved.
//

#import "VedioMomentCell.h"
#import "UIImageView+WebCache.h"

@interface VedioMomentCell ()
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UIButton *zanBtn;

@end

@implementation VedioMomentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Setter
- (void)setComment:(Comment *)comment {
    _comment = comment;
    
    [self.img sd_setImageWithURL:url(comment.userPortraitUrl) placeholderImage:[UIImage imageNamed:@"defaultImage"]];
    self.nameLab.text = comment.userName;
    self.timeLab.text = comment.createTime;
    self.contentLab.text = comment.comment;
}

@end
