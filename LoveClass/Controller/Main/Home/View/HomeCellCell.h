//
//  HomeCellCell.h
//  LoveClass
//
//  Created by apple on 16/8/30.
//  Copyright © 2016年 cyfuer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeCellItem;
@interface HomeCellCell : UICollectionViewCell

@property (strong, nonatomic) HomeCellItem *item;

@end

@interface HomeCellItem : NSObject

@property (copy, nonatomic) NSString *Id;
@property (copy, nonatomic) NSString *tip;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *coversUrl;
@property (assign, nonatomic) NSInteger type;// 0:视频 1:图文

@end

