//
//  MoreVideoCell.m
//  LoveClass
//
//  Created by apple on 16/10/24.
//  Copyright © 2016年 cyfuer. All rights reserved.
//

#import "MoreVideoCell.h"
#import "UIImageView+WebCache.h"

@interface MoreVideoCell ()

@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLab;


@end

@implementation MoreVideoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setSeries:(Series *)series {
    _series = series;
    
    [self.img sd_setImageWithURL:url(series.coversUrl) placeholderImage:[UIImage imageNamed:@"defaultImage"]];
    self.titleLab.text = series.title;
    self.descriptionLab.text = series.tip;
}

@end
