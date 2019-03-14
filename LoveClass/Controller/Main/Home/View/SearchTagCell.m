//
//  SearchTagCell.m
//  LoveClass
//
//  Created by apple on 16/10/19.
//  Copyright © 2016年 cyfuer. All rights reserved.
//

#import "SearchTagCell.h"

@implementation SearchTagCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSearchTag:(SearchTag *)searchTag {
    _searchTag = searchTag;
    
    _lab.text = searchTag.name;
}

@end

@implementation SearchTag

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id":@"id"};
}

@end
