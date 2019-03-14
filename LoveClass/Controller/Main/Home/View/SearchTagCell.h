//
//  SearchTagCell.h
//  LoveClass
//
//  Created by apple on 16/10/19.
//  Copyright © 2016年 cyfuer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SearchTag;

@interface SearchTagCell : UICollectionViewCell

@property (strong, nonatomic) SearchTag *searchTag;

@property (weak, nonatomic) IBOutlet UILabel *lab;

@end

@interface SearchTag : NSObject

@property (copy, nonatomic) NSString *Id;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *createTime;

@end


