//
//  TeacherCell.m
//  LoveClass
//
//  Created by apple on 16/8/30.
//  Copyright © 2016年 cyfuer. All rights reserved.
//

#import "TeacherCell.h"
#import "UIImageView+WebCache.h"

@interface TeacherCell ()
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *lab;

@end

@implementation TeacherCell

- (void)setTeacher:(Teacher *)teacher {
    _teacher = teacher;
    
    [_img sd_setImageWithURL:url(teacher.portraitUrl) placeholderImage:[UIImage imageNamed:@"defaultImage"]];
    
    [_lab setText:teacher.nickname];
}

@end
