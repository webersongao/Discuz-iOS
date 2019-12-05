//
//  ForumReusableView.h
//  DiscuzMobile
//
//  Created by HB on 17/5/2.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import <UIKit/UIKit.h>
@class DZForumNodeModel;

@interface ForumReusableView : UICollectionReusableView
@property (nonatomic, strong) DZForumNodeModel * node;
@property (nonatomic, strong) UILabel *textLab;
@property (nonatomic, strong) UIButton * button;
@end
