//
//  SearchHistoryHeader.h
//  LoveClass
//
//  Created by apple on 16/10/19.
//  Copyright © 2016年 cyfuer. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^clearAction) ();
@interface SearchHistoryHeader : UICollectionReusableView

@property (weak, nonatomic) clearAction clearAction;

@end
