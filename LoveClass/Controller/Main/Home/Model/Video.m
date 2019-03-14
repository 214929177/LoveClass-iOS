//
//  Video.m
//  LoveClass
//
//  Created by apple on 16/9/28.
//  Copyright © 2016年 cyfuer. All rights reserved.
//

#import "Video.h"

@implementation Video

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id":@"id",
             @"Description":@"description"};
}

@end
