//
//  Series.h
//  LoveClass
//
//  Created by apple on 16/9/29.
//  Copyright © 2016年 cyfuer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Video.h"


@class Teacher,Comment;
@interface Series : NSObject

@property (copy, nonatomic) NSString *Id;
@property (copy, nonatomic) NSString *tip;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *type;
@property (copy, nonatomic) NSString *year;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *label;
@property (copy, nonatomic) NSString *userId;
@property (copy, nonatomic) NSString *userName;
@property (copy, nonatomic) NSString *category;
@property (copy, nonatomic) NSString *coversUrl;
@property (copy, nonatomic) NSString *Description;

@property (strong, nonatomic) NSArray<Video *> *videos;
@property (strong, nonatomic) Teacher *teacher;
@property (strong, nonatomic) NSMutableArray<Comment *> *comments;

@end


@interface Teacher : NSObject

@property (copy, nonatomic) NSString *userId;
@property (copy, nonatomic) NSString *nickname;
@property (copy, nonatomic) NSString *portraitUrl;
@property (copy, nonatomic) NSString *Description;


@end

@interface Comment : NSObject

@property (copy, nonatomic) NSString *Id;
@property (copy, nonatomic) NSString *outerId;
@property (copy, nonatomic) NSString *userId;
@property (copy, nonatomic) NSString *userName;
@property (copy, nonatomic) NSString *userPortraitUrl;
@property (copy, nonatomic) NSString *comment;
@property (copy, nonatomic) NSString *praiseTimes;
@property (copy, nonatomic) NSString *createTime;// 发布时间时间戳

@end
