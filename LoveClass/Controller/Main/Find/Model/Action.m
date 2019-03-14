
//
//  Action.m
//  LoveClass
//
//  Created by apple on 16/10/10.
//  Copyright © 2016年 cyfuer. All rights reserved.
//

#import "Action.h"

@implementation Action

+ (instancetype)instanceWityId:(NSString *)Id imageName:(NSString *)imageName title:(NSString *)title {
    Action *action = [[Action alloc] init];
    action.Id = Id;
    action.image = [UIImage imageNamed:imageName];
    action.title = title;
    return action;
}

@end
