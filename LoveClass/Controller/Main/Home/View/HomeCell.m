//
//  HomeCell.m
//  LoveClass
//
//  Created by apple on 16/8/30.
//  Copyright © 2016年 cyfuer. All rights reserved.
//

#import "HomeCell.h"

@interface HomeCell ()

@property (weak, nonatomic) IBOutlet UICollectionView *collection;

@end

@implementation HomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setItem:(HomeItem *)item {
    _item = item;
    [_collection reloadData];
}

@end

@implementation HomeItem

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id":@"id"};
}

+ (HomeItem *)instanceWithImg:(NSString *)img title:(NSString *)title data:(NSArray *)array {
    HomeItem *item = [[HomeItem alloc] init];
    item.img = [UIImage imageNamed:img];
    item.title = title;
    item.data = array;
    return item;
}

@end
