//
//  HomeCell.h
//  LoveClass
//
//  Created by apple on 16/8/30.
//  Copyright © 2016年 cyfuer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeItem;
@interface HomeCell : UITableViewCell

@property (strong, nonatomic) HomeItem *item;

@end

@interface HomeItem : NSObject

@property (strong, nonatomic) NSString *Id;
@property (strong, nonatomic) UIImage *img;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSArray *data;

+ (HomeItem *)instanceWithImg:(NSString *)img title:(NSString *)title data:(NSArray *)array;

@end
