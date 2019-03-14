//
//  VedioMovieCell.m
//  LoveClass
//
//  Created by apple on 16/9/27.
//  Copyright © 2016年 cyfuer. All rights reserved.
//

#import "VedioMovieCell.h"

@interface VedioMovieCell ()

@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *orderLab;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;


@end

@implementation VedioMovieCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark - Setter
- (void)setVideo:(Video *)video {
    _video = video;
    
    self.titleLab.text = video.name;
    self.timeLab.text = video.duration;
    
    if (video.isPlaying) {
        _img.image = [UIImage imageNamed:@"vedio_movieplay"];
        _titleLab.textColor = [UIColor blackColor];
    } else {
        _img.image = [UIImage imageNamed:@"vedio_moviestop"];
        _titleLab.textColor = hexColor(@"7A7A7A");
    }
}


@end
