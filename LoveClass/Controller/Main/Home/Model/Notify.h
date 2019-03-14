//
//  Notify.h
//  LoveClass
//
//  Created by apple on 16/10/13.
//  Copyright © 2016年 cyfuer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Notify : NSObject

@property (copy, nonatomic) NSString *nid;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *message;
@property (copy, nonatomic) NSString *createTime;

@end
