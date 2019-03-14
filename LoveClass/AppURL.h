//
//  AppURL.h
//  LoveClass
//
//  Created by apple on 16/9/26.
//  Copyright © 2016年 cyfuer. All rights reserved.
//

#ifndef AppURL_h
#define AppURL_h

//#define HOST @"http://120.76.31.154:80/app-server"
#define HOST @"http://192.168.17.91:8081"
//#define HOST @"http://app.pua110.com/app-server"
// 登录
#define HTTP_Login  [NSString stringWithFormat:@"%@/app/login.do",HOST]

// 首页
#define HTTP_Home  [NSString stringWithFormat:@"%@/home/index.do",HOST]

// 退出
#define HTTP_Logout  [NSString stringWithFormat:@"%@/app/logout.do",HOST]

// 获取注册验证码
#define HTTP_GetVerificationCode  [NSString stringWithFormat:@"%@/app/getVerificationCode.do",HOST]

// 注册新账号
#define HTTP_Register  [NSString stringWithFormat:@"%@/app/register.do",HOST]

// 系列详情
#define HTTP_SeriesDetail  [NSString stringWithFormat:@"%@/media/seriesDetail.do",HOST]

// 视频详情
#define HTTP_VideoDetail  [NSString stringWithFormat:@"%@/media/videoDetail.do",HOST]

// 发现－优质导师
#define HTTP_Teachers  [NSString stringWithFormat:@"%@/discover/outstandingTutor.do",HOST]

// 发现－更多优质导师
#define HTTP_MoreTeachers  [NSString stringWithFormat:@"%@/discover/moreOutstandingTutor.do",HOST]

// 发现－分类－系列列表
#define HTTP_Categories  [NSString stringWithFormat:@"%@/discover/seriesListByCategory.do",HOST]

// 全局－写评论
#define HTTP_AddComment  [NSString stringWithFormat:@"%@/comment/addComment.do",HOST]

// 全局－评论列表
#define HTTP_Comments  [NSString stringWithFormat:@"%@/comment/commentList.do",HOST]

// 全局－评论－点赞
#define HTTP_Zan  [NSString stringWithFormat:@"%@/comment/praiseComment.do",HOST]

// 全局－搜索－推荐
#define HTTP_Search_Recommend  [NSString stringWithFormat:@"%@/search/searchRecommend.do",HOST]

// 全局－搜索
#define HTTP_Search  [NSString stringWithFormat:@"%@/search/search.do",HOST]

// 个人－获取通知
#define HTTP_Notifies  [NSString stringWithFormat:@"%@/home/sysNotify.do",HOST]

// 系列／图文－收藏
#define HTTP_Favor  [NSString stringWithFormat:@"%@/media/collect.do",HOST]

// 系列／图文－取消收藏
#define HTTP_UnFavor  [NSString stringWithFormat:@"%@/media/cancelCollect.do",HOST]

// 用户－头像上传
#define HTTP_UploadAvatar  [NSString stringWithFormat:@"%@/user/uploadPortrait.do",HOST]

// 用户－信息更新
#define HTTP_UpdateUserInfo  [NSString stringWithFormat:@"%@/user/updateUserInfo.do",HOST]

// 用户－信息
#define HTTP_UserInfo  [NSString stringWithFormat:@"%@/user/userInfo.do",HOST]

#endif /* AppURL_h */
