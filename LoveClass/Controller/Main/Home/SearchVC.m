//
//  SearchVC.m
//  LoveClass
//
//  Created by apple on 16/10/19.
//  Copyright © 2016年 cyfuer. All rights reserved.
//

#import "SearchVC.h"
#import "SearchTagCell.h"
#import "SearchHistoryCell.h"
#import "SearchHistoryHeader.h"
#import "SearchVideoCell.h"
#import "Series.h"
#import "UIView+extra.h"
#import "VideoVC.h"

@interface SearchVC ()<UISearchBarDelegate> {
    NSArray <SearchTag *>*hots;
    NSMutableArray *histories;
    NSArray <Series *>*videos;
    
}

@property (assign, nonatomic) BOOL isSearch;
@property (strong, nonatomic) UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation SearchVC

#pragma mark - Initialize
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupCollectionView];
    
    [self requestForHots];
}

- (void)setupNav {
    
    CGFloat h = 30;
    CGFloat btn_w = 60;
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainScreen_Width, h)];
    
    UIView *maskView = [[UIView alloc] initWithFrame:self.view.bounds];
    maskView.backgroundColor = [UIColor blackColor];
    maskView.alpha = 0.3;
    [maskView addTargetForEndEdit];
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(7, 0, v.width - 7*2 - btn_w, h)];
    self.searchBar.delegate = self;
    self.searchBar.placeholder = @"搜索课程";
    self.searchBar.inputAccessoryView = maskView;
    self.searchBar.returnKeyType = UIReturnKeySearch;
    self.searchBar.barTintColor = [UIColor colorWithRed:0.06 green:0.05 blue:0.05 alpha:1.00];
    
    UIButton *cancleBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.searchBar.right, 0, btn_w, h)];
    [cancleBtn addTarget:self action:@selector(cancleSearch) forControlEvents:UIControlEventTouchUpInside];
    [cancleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancleBtn.titleLabel.font = Font15;
    
    [v addSubview:self.searchBar];
    [v addSubview:cancleBtn];
    
    [self setNavBarTitleViewWithView:v];
}

- (void)cancleSearch {
    [self setEditing:NO animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setupCollectionView {
    [self.collectionView registerNib:[UINib nibWithNibName:@"SearchTagCell" bundle:nil] forCellWithReuseIdentifier:@"SearchTagCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"SearchHistoryCell" bundle:nil] forCellWithReuseIdentifier:@"SearchHistoryCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"SearchVideoCell" bundle:nil] forCellWithReuseIdentifier:@"SearchVideoCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"SearchHistoryHeader" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SearchHistoryHeader"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 每次打开本界面都要保证刷新
    histories = [NSMutableArray arrayWithArray:[User loadUser].searchHistories];
    [self.collectionView reloadData];
}

#pragma mark - Private
- (void)updateSearchHistoriesBySearchContent:(NSString *)content {
    // 更新搜索纪录列表
    
    if (!isEmpty(content)) {
        if (histories && histories.count == 10) {
            [histories removeLastObject];
        }
        [histories insertObject:content atIndex:0];
        
        User *u = [User loadUser];
        u.searchHistories = (NSArray *)histories;
        [User save:u];
    }
}

#pragma mark - UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    if (isEmpty(searchBar.text)) {
        self.isSearch = NO;
    } else {
        [self updateSearchHistoriesBySearchContent:searchBar.text];
        [self requestForSearchWithKeyword:searchBar.text];
    }
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - UICollectionViewDelegate && UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (self.isSearch) {
        return 1;
    }
    return 2;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.isSearch) {
        return videos.count;
    } else {
        if(section == 0) {
            return hots.count;
        } else {
            return histories.count;
        }
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.isSearch) {
        SearchVideoCell *videoCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SearchVideoCell" forIndexPath:indexPath];
        videoCell.series = videos[indexPath.row];
        return videoCell;
    } else {
        if(indexPath.section == 0) {
            SearchTagCell *tagCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SearchTagCell" forIndexPath:indexPath];
            tagCell.layer.cornerRadius = 2.f;
            tagCell.layer.masksToBounds = YES;
            tagCell.searchTag = hots[indexPath.row];
            return tagCell;
            
        } else {
            SearchHistoryCell *historyCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SearchHistoryCell" forIndexPath:indexPath];
            historyCell.lab.text = histories[indexPath.row];
            return historyCell;
        }
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.isSearch) {
        return CGSizeMake(MainScreen_Width, 90);
    } else {
        if(indexPath.section == 0)
        {
            SearchTag *tags = hots[indexPath.row];
            CGSize size = [tags.name sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:24]}];
            return CGSizeMake(size.width,25);
        }
        else
        {
            return CGSizeMake(MainScreen_Width,25);
        }
    }
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (self.isSearch) {
        return UIEdgeInsetsZero;
    } else {
        if(section == 0)
        {
            return UIEdgeInsetsMake(20, 16, 20, 16);
        }
        else
        {
            return UIEdgeInsetsMake(5, 5, 5, 5);
        }
    }
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    if (!self.isSearch && section == 1) {
        return CGSizeMake(self.view.frame.size.width, 44.0);
    }
    return CGSizeZero;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (self.isSearch) {
        return nil;
    } else {
        if([kind isEqualToString:UICollectionElementKindSectionHeader])
        {
            if(indexPath.section == 1)
            {
                SearchHistoryHeader *topColl = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"SearchHistoryHeader" forIndexPath:indexPath];
                topColl.bounds = CGRectMake(0, 0, MainScreen_Width, 30);
                topColl.backgroundColor = [UIColor clearColor];
                return topColl;
            }
        }
        
        return nil;
    }
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isSearch) {
        Series *s = videos[indexPath.row];
        VideoVC *vc = [[VideoVC alloc] init];
        vc.seriesId = s.Id;
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        if(indexPath.section == 0) {
            SearchTag *hot = hots[indexPath.row];
            self.searchBar.text = hot.name;
            [self requestForSearchWithKeyword:hot.name];
            [self updateSearchHistoriesBySearchContent:hot.name];
        }
        else {
            NSString *str = histories[indexPath.row];
            self.searchBar.text = str;
            [self requestForSearchWithKeyword:str];
        }
    }
}

#pragma mark - Setter
- (void)setIsSearch:(BOOL)isSearch {
    _isSearch = isSearch;
    [self.collectionView reloadData];
}

#pragma mark - HTTP

- (void)requestForHots {
    [DFHud showActivityHud];
    [HYBNetworking getWithUrl:HTTP_Search_Recommend
                 refreshCache:YES
                       params:nil
                      success:^(id response){
                          [DFHud hide];
                          
                          NSString *state = response[@"errorCode"];
                          
                          if ([state  integerValue] == 0) {
                              hots = [NSArray yy_modelArrayWithClass:[SearchTag class] json:response[@"data"]];
                              [self.collectionView reloadData];
                          } else {
                              [DFHud showMessageHud:response[@"message"]];
                          }
                      }
                         fail:^(NSError *error){
                             [DFHud hide];
                         }];

}

- (void)requestForSearchWithKeyword:(NSString *)keyword {
    [DFHud showActivityHud];
    [HYBNetworking getWithUrl:HTTP_Search
                 refreshCache:YES
                       params:@{@"keyword":keyword}
                      success:^(id response){
                          [DFHud hide];
                          
                          NSString *state = response[@"errorCode"];
                          
                          if ([state  integerValue] == 0) {
                              videos = [NSArray yy_modelArrayWithClass:[Series class] json:response[@"data"]];
                              if (videos && videos.count) {
                                  self.isSearch = YES;
                              } else {
                                  self.isSearch = NO;
                                  [DFHud showMessageHud:@"没有相关视频"];
                              }
                              
                          } else {
                              [DFHud showMessageHud:response[@"message"]];
                              self.isSearch = NO;
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
