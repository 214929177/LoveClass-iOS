//
//  Action.h
//  LoveClass
//
//  Created by apple on 16/10/10.
//  Copyright © 2016年 cyfuer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Action : NSObject

@property (strong, nonatomic) NSString *Id;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *imgUrl;

+ (instancetype)instanceWityId:(NSString *)Id imageName:(NSString *)imageName title:(NSString *)title;

@end
