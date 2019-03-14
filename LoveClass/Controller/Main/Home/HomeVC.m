//
//  HomeVC.m
//  LoveClass
//
//  Created by Cyfuer on 16/8/29.
//  Copyright © 2016年 cyfuer. All rights reserved.
//

#import "HomeVC.h"
#import "HomeCell.h"
#import "HomeCellCell.h"
#import "SDCycleScrollView.h"
#import "HomeTableSectionHeader.h"
#import "HomeTableSectionFooter.h"

#import "BannerItem.h"
#import "PlayHistoryVC.h"
#import "NotificationVC.h"
#import "VideoVC.h"
#import "ArticleVC.h"
#import "SearchVC.h"
#import "MoreVideoVC.h"

@interface HomeVC ()<UISearchBarDelegate> {
    NSArray *tableData;
    NSArray *banners;
}

@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation HomeVC

#pragma mark - Initialize
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTable];
    [self requestForData];
}

- (void)setupNav {
    self.title = @"首页";
    [self setLeftNavBarItemWithImage:[UIImage imageNamed:@"message"] action:@selector(goMessageVC)];
    [self setRightNavBarItemWithImage:[UIImage imageNamed:@"record"] action:@selector(goPlayHistoryVC)];
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    searchBar.delegate = self;
    searchBar.placeholder = @"搜索课程";
    [self setNavBarTitleViewWithView:searchBar];
}

- (void)setupTable {
    self.table.tableHeaderView = [self tableHeader];
}

- (void)goMessageVC {
    [self.navigationController pushViewController:[NotificationVC new] animated:YES];
}

- (void)goPlayHistoryVC {
    [self.navigationController pushViewController:[PlayHistoryVC new] animated:YES];
}

#pragma mark - Private
// 通过collectionView的tag获取对应的数组数据
- (NSArray *)arrayByCollectionView:(UICollectionView *)view {
    UIView *v = view.superview;
    HomeCell *cell = (HomeCell *)v.superview;
    return cell.item.data;
}

#pragma mark - UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    [self.navigationController pushViewController:[SearchVC new] animated:YES];
    return NO;
}

#pragma mark - UITableViewDataSource && UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeCell"];
    cell.item = tableData[indexPath.section];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return tableData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 30;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    HomeItem *item = tableData[section];
    
    HomeTableSectionHeader *view = [[NSBundle mainBundle] loadNibNamed:@"HomeTableSectionHeader" owner:self options:nil][0];
    view.frame = CGRectMake(0, 0, MainScreen_Width, 40);
    view.img.image = item.img;
    view.img.backgroundColor = nil;
    view.titleLab.text = item.title;
    view.moreBtnAction = ^{
        
    };
    
    return view;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    HomeTableSectionFooter *view = [[NSBundle mainBundle] loadNibNamed:@"HomeTableSectionFooter" owner:self options:nil][0];
    view.frame = CGRectMake(0, 0, MainScreen_Width, 30);
    return view;
}

- (UIView *)tableHeader {
    SDCycleScrollView *scrollView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, MainScreen_Width, 140)];
    return scrollView;
}

#pragma mark - UICollectionViewDataSource && UICollectionViewDelegateFlowLayout && UICollectionViewDelegate

//  UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *array = [self arrayByCollectionView:collectionView];
    return array.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HomeCellCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeCellCell" forIndexPath:indexPath];
    
    NSArray *array = [self arrayByCollectionView:collectionView];
    if (array.count > indexPath.row) {
        cell.item = array[indexPath.row];
    }
    
    return cell;
}

//  UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(120, 120);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return  10;
}

//  UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *array = [self arrayByCollectionView:collectionView];
    HomeCellItem *item = array[indexPath.row];
    
    if (item.type == 0) {
        VideoVC *vc = [VideoVC new];
        vc.seriesId = item.Id;
        [self.navigationController pushViewController:vc animated:YES];
    } else if (item.type == 1) {
        ArticleVC *vc = [ArticleVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    BannerItem *item = banners[index];
    
    if ([item.type isEqualToString:@"article"]) {
        
    } else if ([item.type isEqualToString:@"outside"]) {
        
    }
}

#pragma mark - HTTP
- (void)requestForData {
    [DFHud showActivityHud];
    [HYBNetworking getWithUrl:HTTP_Home
                  refreshCache:NO
                       params:nil
                       success:^(id response){
                           [DFHud hide];
                           
                           NSString *state = response[@"errorCode"];
                           
                           if ([state  integerValue] == 0) {
                               
                               [self updateTable:response];
                               [self updateBanner:response];
                               
                           }
                       }
                          fail:^(NSError *error){
                              [DFHud hide];
                          }];
}

- (void)updateTable:(id)response {
    NSArray *vips = [NSArray yy_modelArrayWithClass:[HomeCellItem class] json:response[@"data"][@"vip"]];
    NSArray *frees = [NSArray yy_modelArrayWithClass:[HomeCellItem class] json:response[@"data"][@"free"]];
    NSArray *hots = [NSArray yy_modelArrayWithClass:[HomeCellItem class] json:response[@"data"][@"host"]];
    NSArray *selectnesses = [NSArray yy_modelArrayWithClass:[HomeCellItem class] json:response[@"data"][@"selectness"]];
    
    HomeCellItem *official = [HomeCellItem yy_modelWithDictionary:response[@"data"][@"exclusive"]];
    HomeCellItem *tip = [HomeCellItem yy_modelWithDictionary:response[@"data"][@"tip"]];
    NSArray *officials = @[o_nil(official, @"HomeCellItem"),
                           o_nil(tip, @"HomeCellItem")];
    
    tableData = @[[HomeItem instanceWithImg:@"offical" title:@"官方专栏" data:officials],
                  [HomeItem instanceWithImg:@"hot" title:@"热门推荐" data:hots],
                  [HomeItem instanceWithImg:@"free" title:@"免费课程" data:frees],
                  [HomeItem instanceWithImg:@"vip" title:@"会员专属" data:vips],
                  [HomeItem instanceWithImg:@"quality" title:@"系列精品课程" data:selectnesses],];
    
    [self.table reloadData];
}

- (void)updateBanner:(id)response {
    NSArray *b = [NSArray yy_modelArrayWithClass:[BannerItem class] json:response[@"data"][@"banner"]];
    banners = b;
    if (b && b.count) {
        ((SDCycleScrollView *)self.table.tableHeaderView).imagesGroup = [self imagesFromBanners:b];
        ((SDCycleScrollView *)self.table.tableHeaderView).titlesGroup = [self titlesFromBanners:b];
        
    }
}

- (NSArray *)imagesFromBanners:(NSArray <BannerItem *>*)array {
    NSMutableArray *images = [NSMutableArray array];
    for (BannerItem *item in array) {
        [images addObject:item.coversUrl];
    }
    return (NSArray *)images;
}

- (NSArray *)titlesFromBanners:(NSArray <BannerItem *>*)array {
    NSMutableArray *titles = [NSMutableArray array];
    for (BannerItem *item in array) {
        [titles addObject:item.title];
    }
    return (NSArray *)titles;
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
