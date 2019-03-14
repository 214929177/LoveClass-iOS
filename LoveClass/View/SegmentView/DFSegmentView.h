//
//  DFSegmentView.h
//  LoveClass
//
//  Created by apple on 16/9/28.
//  Copyright © 2016年 cyfuer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DFSegmentView;
@protocol DFSegmentViewDelegate <NSObject>

- (void)dfSegmentView:(DFSegmentView *)view didSelectedButtonAtIndex:(NSInteger)tag;

@end

@interface DFSegmentView : UIView

@property (weak, nonatomic) id<DFSegmentViewDelegate> delegate;
@property (strong, nonatomic)  NSArray <NSString *> *buttonTitles;

@end
