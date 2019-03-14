//
//  Notify.m
//  LoveClass
//
//  Created by apple on 16/10/13.
//  Copyright © 2016年 cyfuer. All rights reserved.
//

#import "Notify.h"

@implementation Notify

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    NSString *time = [NSString stringWithFormat:@"%@",dic[@"createTime"]];
    _createTime = timeStr(time);
    
    return YES;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    [encoder encodeObject:self.nid forKey:@"nid"];
    [encoder encodeObject:self.title forKey:@"title"];
    [encoder encodeObject:self.message forKey:@"message"];
    [encoder encodeObject:self.createTime forKey:@"createTime"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        //decode properties, other class vars
        self.nid = [decoder decodeObjectForKey:@"nid"];
        self.title = [decoder decodeObjectForKey:@"title"];
        self.message = [decoder decodeObjectForKey:@"message"];
        self.createTime = [decoder decodeObjectForKey:@"createTime"];
    }
    return self;
}

@end
