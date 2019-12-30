//
//  DZThreadLayout.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/24.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DZThreadListModel;

@interface DZThreadLayout : NSObject

@property (nonatomic, assign) CGRect iconFrame;  //!< 头像
@property (nonatomic, assign) CGRect nameFrame;  //!< 昵称
@property (nonatomic, assign) CGRect gradeFrame;  //!< 管理组
@property (nonatomic, assign) CGRect tagFrame;  //!< 置顶 或 精华

@property (nonatomic, assign) CGRect lineOneFrame;  //!< 分割线
@property (nonatomic, assign) CGRect titleFrame;  //!< 标题
@property (nonatomic, assign) CGRect subtitleFrame;  //!< 内容 或 最近回复
@property (nonatomic, assign) CGRect timeFrame;  //!< 时间

@property (nonatomic, assign) CGRect attachFrame;  //!< 附件总高度

@property (nonatomic, assign) CGRect lineTwoFrame;  //!< 分割线
@property (nonatomic, assign) CGRect viewFrame;  //!< 浏览
@property (nonatomic, assign) CGRect replyFrame;  //!< 回复
@property (nonatomic, assign) CGRect zanFrame;  //!< 赞
@property (nonatomic, assign) CGRect lineThreeeFrame;  //!< 分割线

@property (nonatomic, assign) CGFloat cellHeight;  //!< 总高度


- (instancetype)initWithModel:(DZThreadListModel *)Model isList:(BOOL)isList;

@end


