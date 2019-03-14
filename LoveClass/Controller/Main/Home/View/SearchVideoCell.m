//
//  SearchVideoCell.m
//  LoveClass
//
//  Created by apple on 16/10/19.
//  Copyright © 2016年 cyfuer. All rights reserved.
//

#import "SearchVideoCell.h"
#import "UIImageView+WebCache.h"

@interface SearchVideoCell()

@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *descripLab;


@end

@implementation SearchVideoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSeries:(Series *)series {
    _series = series;
    
    [self.img sd_setImageWithURL:url(series.coversUrl) placeholderImage:[UIImage imageNamed:@"defaultImage"]];
    self.titleLab.text = series.title;
    self.descripLab.text = series.tip;
}

@end
