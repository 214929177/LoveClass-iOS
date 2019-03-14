//
//  VideoVC.m
//  CloudClassroom
//
//  Created by Cyfuer on 15/4/26.
//  Copyright (c) 2015年 Cyfuer. All rights reserved.
//

#import "VideoVC.h"
#import "UIImageView+WebCache.h"
#import <MediaPlayer/MediaPlayer.h>

#import "VedioMovieCell.h"
#import "VedioMomentCell.h"
#import "VedioMovieSectionHeader.h"
#import "Series.h"
#import "UIImageView+WebCache.h"
#import "ITTARefresh.h"
#import "PlayHistoryItem.h"
#import "NSDate+Utilities.h"

//#import "WXApi.h"
//#import "WeiboApi.h"
//#import "WeiboSDK.h"
//#import <ShareSDK/ShareSDK.h>
//#import <TencentOpenAPI/TencentOAuth.h>
//#import <TencentOpenAPI/QQApiInterface.h>

@interface VideoVC () {
    
//    ASIHTTPRequest *videoRequest;// 实现边下载边播放
//    unsigned long long Recordull;
//    BOOL isPlay;
    
    
    UIButton *currentBtn;// 目录\详情\评论,记录当前选中的按钮
    NSInteger currentVideoIndex;// 当前播放视频的序号
    
    Series *series;
}

@property (weak, nonatomic) IBOutlet UIImageView *vedioDefaultImg;//视频默认背景图，点击该图片播放视频
@property (strong ,nonatomic) ALMoviePlayerController *moviePlayer;


@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIButton *moviesBtn;
@property (weak, nonatomic) IBOutlet UITableView *appriseTable;
@property (weak, nonatomic) IBOutlet UITableView *moviesTable;
@property (weak, nonatomic) IBOutlet UIScrollView *detailView;


@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIView *appriseView;// 写评论视图

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *appriseViewY;


@end

@implementation VideoVC


#pragma mark - Initialize
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.moviePlayer.view];
    
    [self setupTable];
    [self setupContentView];
    
    [self requestForSeriesDetailWithVideoId:self.seriesId];
}

- (void)setupTable {
    self.moviesTable.estimatedRowHeight = 30;
    self.moviesTable.rowHeight = UITableViewAutomaticDimension;
    [self.moviesTable registerNib:[UINib nibWithNibName:@"VedioMovieCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"VedioMovieCell"];
    
    self.appriseTable.estimatedRowHeight = 80;
    self.appriseTable.rowHeight = UITableViewAutomaticDimension;
    [self.appriseTable addHeaderWithCallback:^{
        [self requestForCommentsWithVideoId:self.seriesId page:1];
    }];
    [self.appriseTable addFooterWithCallback:^{
        NSInteger page = series.comments.count / 5 + ((series.comments.count % 5) == 0 ? 0 : 1) + 1;
        [self requestForCommentsWithVideoId:self.seriesId page:page];
    }];
    [self.appriseTable registerNib:[UINib nibWithNibName:@"VedioMomentCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"VedioMomentCell"];
}

- (void)setupContentView {
    [self contentBtnAction:self.moviesBtn];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //视频播放结束通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoFinished) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
    // 键盘显示隐藏
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self hideNav];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self showNav];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)setupView {
//    if (_lesson.lessonId) {
//        [self.appRequest lesson_getDetailCourse_withLessonId:_lesson.lessonId];
//    }
    
    
    
    
    //如果视频免费，上传至我的课程
//    if (!_lesson.price || [_lesson.price intValue] == 0 ) {
//        if (_lesson && !isEmptyStr([AppContent unarchive].userId)) {
//            [self.appRequest user_uploadMyCourses_withLessonArray:@[_lesson] delflag:@"false"];
//        }
//    }
}

//- (void)videoFinished{
//    if (videoRequest) {
//        [videoRequest clearDelegatesAndCancel];
//        videoRequest = nil;
//    }
//}



#pragma mark - Private

#pragma mark @ 视频
- (void)configureViewForOrientation:(UIInterfaceOrientation)orientation {
    CGFloat videoWidth = 0;
    CGFloat videoHeight = 0;
    
    //calulate the frame on every rotation, so when we're returning from fullscreen mode we'll know where to position the movie plauyer
    CGRect rect = CGRectMake(self.view.frame.size.width/2 - videoWidth/2, self.view.frame.size.height/2 - videoHeight/2, videoWidth, videoHeight);
    
    //only manage the movie player frame when it's not in fullscreen. when in fullscreen, the frame is automatically managed
    if (self.moviePlayer.isFullscreen)
        return;
    
    //you MUST use [ALMoviePlayerController setFrame:] to adjust frame, NOT [ALMoviePlayerController.view setFrame:]
    [self.moviePlayer setFrame:rect];
}

//these files are in the public domain and no longer have property rights
- (void)localFile {
    [self.moviePlayer stop];
    NSString *str = [[NSBundle mainBundle]pathForResource:@"无敌惯例军火库" ofType:@"avi"];
    NSURL *url = [NSURL fileURLWithPath:str];
    [self.moviePlayer setContentURL:url];
    [self.moviePlayer stop];
    [self.moviePlayer play];
}

- (void)playVedioWithPath:(NSString *)path {
    NSString *str = [path substringFromIndex:path.length - 3];
    if (![str isEqualToString:@"mp4"]) {
        UIImageView *img = [[UIImageView alloc]initWithFrame:self.moviePlayer.view.bounds];
        img.image = [UIImage imageNamed:@"player_bg.jpg"];
        img.tag = 10001;
        [self.moviePlayer.backgroundView addSubview:img];
    }
    //    [self.moviePlayer.controls setMovieTitle:_lesson.name];
    //    self.moviePlayer.controls.lesson = _lesson;
    [self.moviePlayer stop];
    [self.moviePlayer setContentURL:[NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]];
    [self.moviePlayer prepareToPlay];
}

#pragma mark @ 目录\详情\评论
- (IBAction)contentBtnAction:(UIButton *)sender {
    if (currentBtn.tag != sender.tag) {
        currentBtn.selected = NO;
        NSInteger tag = currentBtn.tag - sender.tag;
        
        sender.selected = YES;
        currentBtn = sender;
        
        [self changeViewByType:sender.tag - 1000 direction:tag];
    }
}

- (void)changeViewByType:(NSInteger)type direction:(NSInteger)tag {
    
    
    CATransition *transition=[[CATransition alloc]init];
    
    //2.设置动画类型,注意对于苹果官方没公开的动画类型只能使用字符串，并没有对应的常量定义
    transition.type = @"push";
    
    //设置子类型
    if (tag > 0) {
        transition.subtype = kCATransitionFromLeft;
    } else {
        transition.subtype = kCATransitionFromRight;
    }
    
    //设置动画时常
    transition.duration = 0.25f;
    
    switch (type) {
        case 0:
        {
            [self.contentView bringSubviewToFront:self.moviesTable];
        }
            
            break;
        case 1:
        {
            [self.contentView bringSubviewToFront:self.detailView];
        }
            
            break;
        case 2:
        {
            [self.contentView bringSubviewToFront:self.appriseTable];
        }
            
            break;
            
        default:
            break;
    }
    
    [self.contentView.layer addAnimation:transition forKey:@"KCTransitionAnimation"];
}

- (IBAction)teacherInfoBtnAction:(id)sender {
    
}

- (void)savePlayHistoriesByVideo:(Video *)video {
    // 生成一条视频纪录
    HistoryVideo *newVideo = [HistoryVideo instanceWithSeriesId:series.Id seriesName:series.name videoId:video.Id videoName:video.name];
    
    // 保持播放纪录
    NSArray *histories = [User loadUser].playHistories;
    
    if (histories && histories.count) {
        PlayHistoryItem *item = histories[0];
        if ([item.date isToday]) {// 播放纪录最新一条的日期是今天，则直接插入
            [item.videos insertObject:newVideo atIndex:0];
        } else {// 生成新的日期纪录
            PlayHistoryItem *newItem = [[PlayHistoryItem alloc] init];
            newItem.date = [NSDate date];
            newItem.videos = [NSMutableArray arrayWithObject:newVideo];
            
            NSMutableArray *newHistories = [NSMutableArray arrayWithObject:newItem];
            [newHistories addObjectsFromArray:histories];
            histories = (NSArray *)newHistories;
        }
    } else {// 生成新的日期纪录,代码同上
        PlayHistoryItem *newItem = [[PlayHistoryItem alloc] init];
        newItem.date = [NSDate date];
        newItem.videos = [NSMutableArray arrayWithObject:newVideo];
        
        NSMutableArray *newHistories = [NSMutableArray arrayWithObject:newItem];
        [newHistories addObjectsFromArray:histories];
        histories = (NSArray *)newHistories;
    }
    
    User *u = [User loadUser];
    u.playHistories = histories;
    [User save:u];
}

#pragma mark @ 底部工具栏
- (IBAction)backAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    [self.moviePlayer stop];
    self.moviePlayer = nil;
}


- (IBAction)comment:(UIButton *)sender {
//    [self.moviePlayer pause];
    [self.textView becomeFirstResponder];
}

- (IBAction)collect:(UIButton *)sender {
    /*
    sender.selected = !sender.selected;
    
    NSString *delflag = [NSString string];
    if (sender.selected) {
        delflag = @"false";
    }
    else {
        delflag = @"true";
    }
    
    if ([AppUtils isExistenceNetwork]) {
        if (isEmptyStr([AppContent unarchive].userId)) {
            [self showTextActivityIndicator:textActivityIndicatorShowTime Title:@"请先登录"];
        }
        else {
            [self.appRequest user_uploadFavoriteRecords_withLessonArray:@[_lesson] delflag:delflag];
            [self showActivityIndicator:5 Title:nil];
        }
    }
    else {
        [self showTextActivityIndicator:textActivityIndicatorShowTime Title:@"网络异常，请检测网络"];
    }*/
}

- (IBAction)downLoad:(UIButton *)sender {
    /*
    if (isEmptyStr([AppContent unarchive].userId)) {
        [self showTextActivityIndicator:textActivityIndicatorShowTime Title:@"请先登录"];
    }
    else {
        if ([AppUtils isExistenceNetwork]) {
            switch ([AppUtils networkStatus]) {
                case NotReachable:
                    
                    break;
                case ReachableViaWWAN:
                {
                    if ([AppContent unarchive].isLoadIn2G3G) {
                        [[FIleDownLoadManager sharedFilesDownManage] downFileUrl:[_lesson.downLoadAddress stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding] filename:[NSString stringWithFormat:@"%@.mp4",_lesson.name] filetarget:@"mp4"];
                    }
                    else {
                        [self showAlertView:@"温馨提示" andMessage:@"您已设置不在2G/3G环境下载，当前为2G/3G环境，是否继续下载" andCancelBtnTitle:@"确定" tag:10001 otherBtn:@[@"取消"]];
                    }
                    
                }
                    
                    break;
                case ReachableViaWiFi:
                    [[FIleDownLoadManager sharedFilesDownManage] downFileUrl:[_lesson.downLoadAddress stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding] filename:[NSString stringWithFormat:@"%@.mp4",_lesson.name] filetarget:@"mp4"];
                    break;
            }
        }
        else {
            
        }
    }*/
}

- (IBAction)share:(UIButton *)sender {
    /*
    NSString *url = [NSString stringWithFormat:@"%@%@",ShareVedioURL,self.lesson.lessonId];
    UIImage *img = [self.moviePlayer thumbnailImageAtTime:0.1 timeOption:MPMovieTimeOptionNearestKeyFrame];
    
    NSArray *shareList = [ShareSDK getShareListWithType:ShareTypeWeixiSession,ShareTypeWeixiTimeline, ShareTypeQQSpace, ShareTypeSinaWeibo, ShareTypeQQ,nil];
    
    //创建分享内容
    id<ISSContent> publishContent = [ShareSDK content:self.lesson.about
                                       defaultContent:@"恋爱公开课"
                                                image:[ShareSDK jpegImageWithImage:img quality:0.7]
                                                title:self.lesson.name
                                                  url:url
                                          description:self.lesson.about
                                            mediaType:SSPublishContentMediaTypeNews];
    
    //创建容器
    id<ISSContainer> container = [ShareSDK container];
    [container setIPadContainerWithView:sender arrowDirect:UIPopoverArrowDirectionUp];
    
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                         allowCallback:YES
                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
                                                          viewDelegate:nil
                                               authManagerViewDelegate:nil];
    
    //在授权页面中添加关注官方微博
    [authOptions setFollowAccounts:[NSDictionary dictionaryWithObjectsAndKeys:
                                    [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],
                                    SHARE_TYPE_NUMBER(ShareTypeSinaWeibo),
                                    [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],
                                    SHARE_TYPE_NUMBER(ShareTypeTencentWeibo),
                                    nil]];
    
    //显示分享菜单
    [ShareSDK showShareActionSheet:container
                         shareList:shareList
                           content:publishContent
                     statusBarTips:YES
                       authOptions:authOptions
                      shareOptions:[ShareSDK defaultShareOptionsWithTitle:nil
                                                          oneKeyShareList:[NSArray defaultOneKeyShareList]
                                                           qqButtonHidden:NO
                                                    wxSessionButtonHidden:NO
                                                   wxTimelineButtonHidden:NO
                                                     showKeyboardOnAppear:NO
                                                        shareViewDelegate:nil
                                                      friendsViewDelegate:nil
                                                    picViewerViewDelegate:nil]
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                if (state == SSPublishContentStateSuccess)
                                {
                                    [self showAlertView:@"温馨提示" andMessage:@"分享成功" andCancelBtnTitle:@"确定"];
                                }
                                else if (state == SSPublishContentStateFail)
                                {
                                    NSString *content = [NSString stringWithFormat:@"分享失败,%@",[error errorDescription]];
                                    [self showAlertView:@"温馨提示" andMessage:content andCancelBtnTitle:@"确定"];
                                }
                            }];
     */
}

// 取消评论
- (IBAction)cancleAppriseBtnAction:(id)sender {
    self.textView.text = nil;
    [self.textView resignFirstResponder];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    
    // 获取通知的信息字典
    NSDictionary *userInfo = [notification userInfo];
    
    // 获取键盘弹出后的rect
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    
    // 获取键盘弹出动画时间
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    // do something...
    self.appriseViewY.constant = keyboardRect.size.height + self.appriseView.height;
    [UIView animateWithDuration:animationDuration animations:^{
        [self.view layoutIfNeeded];
    }];
}


- (void)keyboardWillHide:(NSNotification *)notification {
    
    // 获取通知信息字典
    NSDictionary* userInfo = [notification userInfo];
    
    // 获取键盘隐藏动画时间
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    // do something...
    self.appriseViewY.constant = 0;
    [UIView animateWithDuration:animationDuration animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - UITextViewDelegate
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text {
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        [self addComment];
        return NO;
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    [textView scrollRectToVisible:CGRectMake(0, textView.contentSize.height - 10, textView.contentSize.width, 10) animated:YES];
}

- (void)addComment {
    [self requestForAddComment:self.seriesId content:self.textView.text];
    
}

#pragma mark  -  ALMoviePlayerController Delegate
- (void)moviePlayerWillMoveFromWindow {
    if (![self.view.subviews containsObject:self.moviePlayer.view])
        [self.view addSubview:self.moviePlayer.view];
    
    [self.moviePlayer setFrame:[self movieFrame]];
    UIView *view = [self.moviePlayer.backgroundView viewWithTag:10001];
    view.frame = self.moviePlayer.view.bounds;
}

- (void)moviePlayerWillMoveToWindow {
    UIView *view = [self.moviePlayer.backgroundView viewWithTag:10001];
    view.frame = CGRectMake(0, 0, MainScreen_Height, MainScreen_Width);
}

- (void)movieTimedOut {
    [DFHud showMessageHud:@"网络不稳定，视频加载失败"];
}

- (void)moviePlayerWillBeginPlay {
    
}

#pragma mark - UITableViewDataSource && UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.moviesTable) {
        return 1;
    } else if (tableView == self.appriseTable) {
        return 1;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.moviesTable) {
        return series.videos.count;
    } else if (tableView == self.appriseTable) {
        return series.comments.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.moviesTable) {
        VedioMovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VedioMovieCell"];
        
        if (series.videos.count > indexPath.row) {
            Video *video = series.videos[indexPath.row];
            cell.video = video;
        }
        
        return cell;
    } else if (tableView == self.appriseTable) {
        VedioMomentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VedioMomentCell"];
        
        if (series.comments.count > indexPath.row) {
            Comment *comment = series.comments[indexPath.row];
            cell.comment = comment;
        }
        
        return cell;
    }
    
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView == self.moviesTable) {
        return 30;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    /*
    if (tableView.tag == 0) {// 推荐
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.frame), 44)];
        view.backgroundColor = getColorWithHexStr(@"e4e4e4");
        
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 44)];
        lab.font = [UIFont systemFontOfSize:15];
        lab.text = @"课程简介";
        lab.textColor = getColorWithHexStr(@"434343");
        [view addSubview:lab];
        
        UILabel *lab0 = [[UILabel alloc]initWithFrame:CGRectMake(view.bounds.size.width - 10 -100, 0, 100, 44)];
        lab0.font = [UIFont systemFontOfSize:12];
        lab0.textAlignment = NSTextAlignmentRight;
        lab0.text = [NSString stringWithFormat:@"播放 %@",_lesson.playCount];
        lab0.textColor = [UIColor lightGrayColor];
        [view addSubview:lab0];
        return view;
    }
    else {
        return nil;
    }
     */
    return  nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.moviesTable) {
        
        if (series.videos.count > indexPath.row) {
            // 上次选择的视频
            if (currentVideoIndex >= 0) {
                Video *lastVideo = series.videos[currentVideoIndex];
                lastVideo.isPlaying = NO;
            }
            
            // 当前选择的视频
            Video *video = series.videos[indexPath.row];
            video.isPlaying = YES;
            
            // 生成播放纪录
            [self savePlayHistoriesByVideo:video];
            
            currentVideoIndex = indexPath.row;
            [tableView reloadData];
            
            [self playVedioWithPath:video.resourceUrl];
        }
    }
    /*
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return;
        }
        else if (indexPath.row == 1) {// 讲师
            [self.moviePlayer pause];// 先暂停视频
            TeacherVC *vc = [[TeacherVC alloc]init];
            vc.teacher = _lesson.teacher;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        else if (indexPath.row == 2) {// 评论
            [self.moviePlayer pause];// 先暂停视频
            CommentVC *vc = [[CommentVC alloc]init];
            vc.lessonId = _lesson.lessonId;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }*/
}


#pragma mark - UIApplicationDelegate
- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - UIViewController (UIViewControllerRotation)

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self configureViewForOrientation:toInterfaceOrientation];
}

#pragma mark - HTTP

- (void)requestForSeriesDetailWithVideoId:(NSString *)videoId {
    if (isEmpty(videoId)) {
        [DFHud showMessageHud:@"数据异常，请回到首页重新进入"];
    } else {
        [DFHud showActivityHud];
        [HYBNetworking getWithUrl:HTTP_SeriesDetail
                     refreshCache:NO
                           params:@{@"seriesId":videoId}
                          success:^(id response){
                              [DFHud hide];
                              
                              NSString *state = response[@"errorCode"];
                              
                              if ([state  integerValue] == 0) {
                                  series = [Series yy_modelWithDictionary:response[@"data"][@"series"]];
                                  series.videos = [NSArray yy_modelArrayWithClass:[Video class] json:response[@"data"][@"videoList"]];
                                  
                                  [self updateMoviesTable:series];
                                  [self updateDetail:series];
                              } else {
                                  [DFHud showMessageHud:response[@"message"]];
                              }
                          }
                             fail:^(NSError *error){
                                 [DFHud hide];
                             }];
    }
}

- (void)requestForAddComment:(NSString *)seriesId content:(NSString *)content {
    if (![User loadUser].isLogin || isEmpty(seriesId)) {
        [DFHud showMessageHud:@"请先登录"];
    } else if (isEmpty(content)) {
        [DFHud showMessageHud:@"您还未输入评论"];
    } else {
        [DFHud showActivityHud];
        [HYBNetworking postWithUrl:HTTP_AddComment
                     refreshCache:NO
                           params:@{@"outerId":seriesId,
                                    @"type":@"0",
                                    @"comment":content}
                          success:^(id response){
                              [DFHud hide];
                              
                              NSString *state = response[@"errorCode"];
                              
                              if ([state  integerValue] == 0) {
                                  self.textView.text = nil;
                              } else {
                                  [self.textView becomeFirstResponder];
                                  [DFHud showMessageHud:response[@"message"]];
                              }
                          }
                             fail:^(NSError *error){
                                 [DFHud hide];
                             }];
    }
}

- (void)requestForCommentsWithVideoId:(NSString *)videoId page:(NSInteger)page {
    [DFHud showActivityHud];
    [HYBNetworking getWithUrl:HTTP_Comments
                 refreshCache:NO
                       params:@{@"type":@"0",// 0:系列 1：图文
                                @"page":[NSString stringWithFormat:@"%ld",(long)page],
                                @"size":@"5",
                                @"outerId":videoId}
                      success:^(id response){
                          [DFHud hide];
                          
                          [self.appriseTable footerEndRefreshing];
                          [self.appriseTable headerEndRefreshing];
                          NSString *state = response[@"errorCode"];
                          
                          if ([state  integerValue] == 0) {
                              if (page == 1) {
                                  series.comments = [NSMutableArray arrayWithArray:[NSArray yy_modelArrayWithClass:[Comment class] json:response[@"data"]]];
                              } else {
                                  [series.comments addObjectsFromArray:[NSArray yy_modelArrayWithClass:[Comment class] json:response[@"data"]]];
                              }
                              [self.appriseTable reloadData];
                          } else {
                              [DFHud showMessageHud:response[@"message"]];
                          }
                      }
                         fail:^(NSError *error){
                             [DFHud hide];
                             [self.appriseTable footerEndRefreshing];
                             [self.appriseTable headerEndRefreshing];
                         }];

}

// 刷新目录
- (void)updateMoviesTable:(Series *)seris {
    series = seris;
    [self.moviesTable reloadData];
    
    [self requestForCommentsWithVideoId:self.seriesId page:1];
}

// 刷新详情
- (void)updateDetail:(Series *)seris {
    UILabel *seriesNameLab = [self.detailView viewWithTag:1000];
    UILabel *seriesDescripeLab = [self.detailView viewWithTag:1001];
    
    UIImageView *teacherAvatarImg = [self.detailView viewWithTag:1002];
    UILabel *teacherNameLab = [self.detailView viewWithTag:1003];
    UILabel *teacherDescripeLab = [self.detailView viewWithTag:1004];
    
    
    seriesNameLab.text = seris.name;
    seriesDescripeLab.text = seris.Description;
    
    [teacherAvatarImg sd_setImageWithURL:url(seris.teacher.portraitUrl) placeholderImage:[UIImage imageNamed:@"defaultImage"]];
    teacherNameLab.text = seris.teacher.nickname;
    teacherDescripeLab.text = seris.teacher.Description;
}

#pragma mark - Getter
- (ALMoviePlayerController *)moviePlayer {
    if (!_moviePlayer) {
        _moviePlayer = [[ALMoviePlayerController alloc] initWithFrame:[self movieFrame]];
        _moviePlayer.view.alpha = 1.f;
        _moviePlayer.delegate = self;
        
        
        ALMoviePlayerControls *movieControls = [[ALMoviePlayerControls alloc] initWithMoviePlayer:_moviePlayer style:ALMoviePlayerControlsStyleDefault];
        //[movieControls setAdjustsFullscreenImage:NO];
        [movieControls setBarHeight:40];
        [movieControls setBarColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5]];
        [movieControls setTimeRemainingDecrements:YES];
        //[movieControls setFadeDelay:2.0];
        //[movieControls setBarHeight:100.f];
        //[movieControls setSeekRate:2.f];
        

        [_moviePlayer setControls:movieControls];
    }
    return _moviePlayer;
    //THEN set contentURL
    //[self.moviePlayer setContentURL:[NSURL URLWithString:@"http://archive.org/download/WaltDisneyCartoons-MickeyMouseMinnieMouseDonaldDuckGoofyAndPluto/WaltDisneyCartoons-MickeyMouseMinnieMouseDonaldDuckGoofyAndPluto-HawaiianHoliday1937-Video.mp4"]];
}

- (CGRect)movieFrame {
    CGFloat w = MainScreen_Width;
    CGFloat h = MainScreen_Width / 8 * 5;
    return CGRectMake(0, 0, w, h);
}


@end
