//
//  HomeTableSectionHeader.h
//  LoveClass
//
//  Created by apple on 16/8/30.
//  Copyright © 2016年 cyfuer. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^moreBtnAction) ();

@interface HomeTableSectionHeader : UIView
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;
@property (assign, nonatomic) moreBtnAction moreBtnAction;

@end
