//
//  HomeCellCell.m
//  LoveClass
//
//  Created by apple on 16/8/30.
//  Copyright © 2016年 cyfuer. All rights reserved.
//

#import "HomeCellCell.h"
#import "UIImageView+WebCache.h"

@interface HomeCellCell ()
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;

@end

@implementation HomeCellCell

- (void)setItem:(HomeCellItem *)item {
    _item = item;
    
    [_img sd_setImageWithURL:url(item.coversUrl) placeholderImage:[UIImage imageNamed:@"defaultImage"]];
    [_titleLab setText:nulls(item.title)];
    [_contentLab setText:nulls(@"")];// cyfuer
}

@end

@implementation HomeCellItem

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id":@"id"};
}

@end
