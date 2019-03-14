//
//  FindVC.m
//  LoveClass
//
//  Created by Cyfuer on 16/8/29.
//  Copyright © 2016年 cyfuer. All rights reserved.
//

#import "FindVC.h"
#import "TeacherCell.h"
#import "FindActionCell.h"
#import "Action.h"
#import "Series.h"

@interface FindVC () {
    NSArray *teachers;
    NSArray *actions;
}

@property (weak, nonatomic) IBOutlet UICollectionView *teacherCollection;
@property (weak, nonatomic) IBOutlet UICollectionView *findActionCollection;

@end

@implementation FindVC

#pragma mark - Intialize
- (void)viewDidLoad {
    [super viewDidLoad];
    
    actions = @[[Action instanceWityId:0 imageName:@"rank" title:@"热门排行榜"],
                [Action instanceWityId:0 imageName:@"rank" title:@"热门排行榜"],
                [Action instanceWityId:0 imageName:@"rank" title:@"热门排行榜"],
                [Action instanceWityId:0 imageName:@"rank" title:@"热门排行榜"],
                [Action instanceWityId:0 imageName:@"rank" title:@"热门排行榜"],
                [Action instanceWityId:0 imageName:@"rank" title:@"热门排行榜"],
                [Action instanceWityId:0 imageName:@"rank" title:@"热门排行榜"]];
    [self.findActionCollection reloadData];
    
    [self requestForTeachers];
}

- (void)setupNav {
    self.title = @"发现";
}

#pragma mark - UICollectionViewDataSource && UICollectionViewDelegateFlowLayout&& UICollectionViewDelegate

//  UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView == self.teacherCollection) {
        return teachers.count;
    }
    return actions.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == self.teacherCollection) {
        TeacherCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TeacherCell" forIndexPath:indexPath];
        
        if (teachers.count > indexPath.row) {
            cell.teacher = teachers[indexPath.row];
        }
        
        return cell;
    }
    else if (collectionView == self.findActionCollection) {
        FindActionCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FindActionCell" forIndexPath:indexPath];
        
        if (actions.count > indexPath.row) {
            cell.action = actions[indexPath.row];
        }
        
        return cell;
    }
    
    return nil;
}

//  UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == self.teacherCollection) {
        return CGSizeMake(60, 70);
    }
    
    CGFloat h = MainScreen_Width/2;
    return CGSizeMake(h, h);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (collectionView == self.teacherCollection) {
        CGFloat marginW = (MainScreen_Width - (60 * 4)) / 5;
        return UIEdgeInsetsMake(20, marginW, 20, marginW);;
    }
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (collectionView == self.teacherCollection) {
        CGFloat marginW = (MainScreen_Width - (60 * 4)) / 5;
        return marginW;
    }
    
    return 0;
}

//  UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

#pragma mark - HTTP
- (void)requestForTeachers {
    [DFHud showActivityHud];
    [HYBNetworking getWithUrl:HTTP_Teachers
                 refreshCache:NO
                       params:nil
                      success:^(id response){
                          [DFHud hide];
                          
                          NSString *state = response[@"errorCode"];
                          
                          if ([state  integerValue] == 0) {
                              
                              teachers = [NSArray yy_modelArrayWithClass:[Teacher class] json:response[@"data"]];
                              [self.teacherCollection reloadData];
                          } else {
                              [DFHud showMessageHud:response[@"message"]];
                          }
                      }
                         fail:^(NSError *error){
                             [DFHud hide];
                         }];
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
