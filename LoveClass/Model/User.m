//
//  User.m
//  CNMedicalForDoctor
//
//  Created by Cyfuer on 15-1-23.
//  Copyright (c) 2015年 Rworld. All rights reserved.
//

#import "User.h"

@implementation User

#pragma mark - 属性归档

- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    
    [encoder encodeObject:self.uid forKey:@"uid"];
    [encoder encodeObject:self.pwd forKey:@"pwd"];
    [encoder encodeObject:self.account forKey:@"account"];
    [encoder encodeObject:self.nickname forKey:@"nickname"];
    [encoder encodeObject:self.phone forKey:@"phone"];
    [encoder encodeObject:self.virtualMoney forKey:@"virtualMoney"];
    [encoder encodeObject:self.portraitUrl forKey:@"portraitUrl"];
    [encoder encodeBool:self.isLogin forKey:@"isLogin"];
    [encoder encodeObject:self.notifies forKey:@"notifies"];
    [encoder encodeInteger:self.maxId forKey:@"maxId"];
    [encoder encodeObject:self.searchHistories forKey:@"searchHistories"];
    [encoder encodeObject:self.Description forKey:@"Description"];
    [encoder encodeObject:self.playHistories forKey:@"playHistories"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        //decode properties, other class vars
        self.uid = [decoder decodeObjectForKey:@"uid"];
        self.account = [decoder decodeObjectForKey:@"account"];
        self.pwd = [decoder decodeObjectForKey:@"pwd"];
        self.nickname = [decoder decodeObjectForKey:@"nickname"];
        self.phone = [decoder decodeObjectForKey:@"phone"];
        self.portraitUrl = [decoder decodeObjectForKey:@"portraitUrl"];
        self.virtualMoney = [decoder decodeObjectForKey:@"virtualMoney"];
        self.isLogin = [decoder decodeBoolForKey:@"isLogin"];
        self.notifies = [decoder decodeObjectForKey:@"notifies"];
        self.maxId = [decoder decodeIntegerForKey:@"maxId"];
        self.searchHistories = [decoder decodeObjectForKey:@"searchHistories"];
        self.Description = [decoder decodeObjectForKey:@"Description"];
        self.playHistories = [decoder decodeObjectForKey:@"playHistories"];
    }
    return self;
}


+ (void)save:(User *)user {
    NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:user];
    [[NSUserDefaults standardUserDefaults] setObject:userData forKey:@"APP_USER"];
}

+ (User *)loadUser {
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"APP_USER"];
    User *obj = (User *)[NSKeyedUnarchiver unarchiveObjectWithData:data];
    return obj ? obj : [[User alloc] init];
}

+ (void)deleteUser {
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"APP_USER"];
}

#pragma mark - Json
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Description":@"description"};
}

@end
