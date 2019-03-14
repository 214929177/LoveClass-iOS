//
//  PlayHistoryCell.m
//  LoveClass
//
//  Created by apple on 16/9/22.
//  Copyright © 2016年 cyfuer. All rights reserved.
//

#import "PlayHistoryCell.h"

@interface PlayHistoryCell ()
@property (weak, nonatomic) IBOutlet UILabel *seriesLab;
@property (weak, nonatomic) IBOutlet UILabel *videoLab;


@end

@implementation PlayHistoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setVideo:(HistoryVideo *)video {
    _video = video;
    self.seriesLab.text = video.seriesName;
    self.videoLab.text = video.videoName;
}

@end
