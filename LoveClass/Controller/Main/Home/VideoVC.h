//
//  VideoVC.h
//  CloudClassroom
//
//  Created by Cyfuer on 15/4/26.
//  Copyright (c) 2015年 Cyfuer. All rights reserved.
//

#import "BaseVC.h"
#import "ALMoviePlayerController.h"

@interface VideoVC : BaseVC <ALMoviePlayerControllerDelegate,UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UIAlertViewDelegate>

@property (strong, nonatomic) NSString *seriesId;

@end
