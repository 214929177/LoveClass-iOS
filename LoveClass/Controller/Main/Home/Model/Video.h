//
//  Video.h
//  LoveClass
//
//  Created by apple on 16/9/28.
//  Copyright © 2016年 cyfuer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Video : NSObject

@property (copy, nonatomic) NSString *Id;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *resourceUrl;
@property (copy, nonatomic) NSString *downloadUrl;
@property (copy, nonatomic) NSString *userName;
@property (copy, nonatomic) NSString *seriesName;
@property (copy, nonatomic) NSString *Description;
@property (copy, nonatomic) NSString *label;
@property (copy, nonatomic) NSString *price;
@property (copy, nonatomic) NSString *duration;

@property (assign, nonatomic) BOOL isPlaying;// 是否正在播放

@end
