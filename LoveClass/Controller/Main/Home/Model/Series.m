//
//  Series.m
//  LoveClass
//
//  Created by apple on 16/9/29.
//  Copyright © 2016年 cyfuer. All rights reserved.
//

#import "Series.h"

@implementation Series

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id":@"id",
             @"Description":@"description"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"teacher":[Teacher class]};
}

@end

@implementation Teacher
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Description":@"description"};
}

@end

@implementation Comment
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id":@"id"};
}

@end
