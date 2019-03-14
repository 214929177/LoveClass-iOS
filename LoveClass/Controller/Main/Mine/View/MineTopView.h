//
//  MineTopView.h
//  LoveClass
//
//  Created by apple on 16/9/28.
//  Copyright © 2016年 cyfuer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CenterImgAndTitleButton.h"

@interface MineTopView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *avatarImg;
@property (weak, nonatomic) IBOutlet UILabel *sayingLab;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;

@property (weak, nonatomic) IBOutlet UIButton *bgBtn;
@property (weak, nonatomic) IBOutlet CenterImgAndTitleButton *playHistoryBtn;
@property (weak, nonatomic) IBOutlet CenterImgAndTitleButton *myFavorBtn;
@property (weak, nonatomic) IBOutlet CenterImgAndTitleButton *myTipBtn;
@property (weak, nonatomic) IBOutlet CenterImgAndTitleButton *myMessageBtn;

@end
