//
//  DZThreadDetailController.m
//  DiscuzMobile
//
//  Created by gensinimac1 on 15/5/14.
//  Copyright (c) 2015年 comsenz-service.com. All rights reserved.
//

#import "DZThreadDetailController.h"
#import "WebViewJavascriptBridge.h"
#import "UIAlertController+Extension.h"

#import "ThreadDetailView.h"
#import "DZSecVerifyView.h"
#import "DZThreadModel.h"
#import "DZPostNetTool.h"
#import "DZThreadTool.h"
#import "WSImageModel.h"
#import "DZForumTool.h"
#import "DZDevice.h"

#import "DZShareCenter.h"
#import "DZWebBrowerHelper.h"

@interface DZThreadDetailController ()<UITextFieldDelegate, DZBaseWebViewDelegate, UIGestureRecognizerDelegate, UIActionSheetDelegate, UIScrollViewDelegate>

@property (nonatomic, assign) BOOL isOnePage;
@property (nonatomic, copy) NSString * forumtitle;
@property (nonatomic, assign) NSInteger currentPageId;  //!< 属性注释
@property (nonatomic, copy) NSString * allowPostSpecial; // 发帖 数帖子的标记

@property (nonatomic, assign) CGFloat currentScale;
@property (nonatomic, strong) ThreadDetailView *detailView; // 详细页view 替换原来的view
@property (nonatomic, strong) WebViewJavascriptBridge * javascriptBridge;

@property (nonatomic, assign) BOOL  isReferenceReply;           // 是否是 引用回复
@property (nonatomic, copy) NSString * noticetrimstr;         // 引用回复内容
@property (nonatomic, copy) NSString * reppid;                // 被引用帖子pid

@property (nonatomic,strong) NSMutableArray *picurlArray; // 页面图片 （接口限制，只有一张）

// 验证码
@property (nonatomic, copy) NSString *preSalkey;
@property (nonatomic, strong) DZThreadModel *threadModel;
@property (nonatomic, strong) DZSecVerifyView *verifyView;

@end

@implementation DZThreadDetailController
@synthesize javascriptBridge = _bridge;

- (void)willMoveToParentViewController:(UIViewController *)parent {
    if (parent == nil) {
        [self.detailView.emoKeyboard hideCustomerKeyBoard];
    }
    [super willMoveToParentViewController:parent];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.HUD hide];
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSDictionary *dic = @{@"tid":self.tid,@"page":checkInteger(self.currentPageId)};
    [DZApiRequest cancelRequest:DZ_Url_ThreadDetail getParameter:dic completion:^(NSString *urlString) {
        DLog(@"取消请求：%@",urlString);
    }];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

#pragma mark - 点击webview的时候收起键盘
- (void)tapGestureAction:(UITapGestureRecognizer *)sender {
    [self.detailView.emoKeyboard hideCustomerKeyBoard];
}

-(void)handlePinchAction:(UIPinchGestureRecognizer *)paramSender {
    if(paramSender.state == UIGestureRecognizerStateEnded) {
        self.currentScale = paramSender.scale;
        self.detailView.webView.scrollView.zoomScale = self.currentScale;
    } else if(paramSender.state == UIGestureRecognizerStateBegan && self.currentScale != 0.0f) {
        paramSender.scale = self.currentScale;
        self.detailView.webView.scrollView.zoomScale = self.currentScale;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeAll;
    }
    self.currentPageId = 1;
    [self.view addSubview:self.detailView];
    [self.detailView.webView.scrollView addSubview:self.emptyView];
    [self commitThreadDetailAction];
    [self newDownLoadData];
    [self addNotifi];
}

- (void)commitThreadDetailAction {
    
    KWEAKSELF;
    self.detailView.emoKeyboard.textBarView.praiseBlock = ^ {
        [weakSelf createPraise:nil];
    };
    self.detailView.emoKeyboard.uploadView.pickerView.navigationController = self.navigationController;
    self.detailView.emoKeyboard.uploadView.pickerView.HUD = self.HUD;
    self.detailView.emoKeyboard.uploadView.pickerView.finishPickingBlock = ^(NSArray *WSImageModels) {
        [weakSelf uploadImageArr:WSImageModels];
    };
    
    self.detailView.emoKeyboard.textBarView.collectionBlock = ^ (UIButton *sender){
        [weakSelf rightBarClick:sender];
    };
    
    self.detailView.emoKeyboard.textBarView.shareBlock = ^ {
        [weakSelf shareSome];
    };
    
    self.detailView.emoKeyboard.sendBlock = ^ {
        [weakSelf sendAction];
    };
    self.detailView.emoKeyboard.textBarView.sendMessageBlock = ^ {
        [weakSelf sendAction];
    };
    
    //刷新  下载数据
    self.detailView.webView.scrollView.mj_header = [DZRefreshHeader headerWithRefreshingBlock:^{
        weakSelf.currentPageId = 1;
        [weakSelf newDownLoadData];
    }];
    
    self.detailView.webView.scrollView.backgroundColor = [UIColor whiteColor];
    self.detailView.webView.scrollView.mj_footer = [DZRefreshFooter footerWithRefreshingBlock:^{
        weakSelf.currentPageId ++;
        [weakSelf newDownLoadData];
    }];
//    ((MJRefreshAutoFooter *)self.detailView.webView.scrollView.mj_footer).triggerAutomaticallyRefreshPercent = -20;
    
    //  创建bridge
    [self createBridge];
}

- (void)uploadImageArr:(NSArray *)imageArr {
    NSString *uploadhash = self.threadModel.uploadhash;
    if (![DataCheck isValidString:uploadhash]) {
        [MBProgressHUD showInfo:@"无权限上传图片"];
        return;
    }
    
    NSDictionary *dic=@{@"hash":uploadhash,
                        @"uid":[DZMobileCtrl sharedCtrl].Global.member_uid,
    };
    NSDictionary * getdic=@{@"fid":self.threadModel.fid};
    [self.HUD showLoadingMessag:@"" toView:self.view];
    [self.detailView.emoKeyboard.uploadView uploadImageArray:imageArr.copy getDic:getdic postDic:dic];
}

#pragma mark - 添加通知
- (void)addNotifi {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusBarTappedAction:) name:DZ_StatusBarTap_Notify object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshCurrentWebView) name:DZ_RefreshWeb_Notify object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginedReshData) name:DZ_LoginedRefreshInfo_Notify object:nil];
}

- (void)refreshCurrentWebView{
    self.currentPageId = 1;
    [self newDownLoadData];
}

#pragma mark - 建立webview桥接
-(void)createBridge {
    
    /*
     * 必写，JS调用OC
     */
    KWEAKSELF;
    _bridge = [WebViewJavascriptBridge bridgeForWebView:self.detailView.webView];
    [_bridge setWebViewDelegate:self];
    
    /*
     *JS调用OC时必须写的，注册一个JS调用OC的方法
     */
    //注册一个供UI端调用的名为testObjcCallback的处理器，并定义用于响应的处理逻辑
    [_bridge registerHandler:@"onShare" handler:^(id data, WVJBResponseCallback responseCallback) {
        // 分享
        [weakSelf shareSome];
    }];
    
    [_bridge registerHandler:@"onPraise" handler:^(id data, WVJBResponseCallback responseCallback) {
        // 点赞
        [weakSelf createPraise:data];
    }];
    
    [_bridge registerHandler:@"supportDebate" handler:^(id data, WVJBResponseCallback responseCallback) {
        if ([DataCheck isValidString:data]) {
            if ([data isEqualToString:@"0"]) {
                DLog(@"支持正方辩手");
            } else if ([data isEqualToString:@"1"]) {
                DLog(@"支持反方辩手");
            }
        }
    }];
    
    [_bridge registerHandler:@"joinDebate" handler:^(id data, WVJBResponseCallback responseCallback) {
        if ([DataCheck isValidString:data]) {
            if ([data isEqualToString:@"0"]) {
                DLog(@"加入正方辩手");
            } else if ([data isEqualToString:@"1"]) {
                DLog(@"加入反方辩手");
            }
        }
    }];
    
    [_bridge registerHandler:@"endDebate" handler:^(id data, WVJBResponseCallback responseCallback) {
        DLog(@"结束辩论");
    }];
    
    [_bridge registerHandler:@"onDiscussUser" handler:^(id data, WVJBResponseCallback responseCallback) {
        // 引用回复
        [weakSelf ReferenceReply:data textview:weakSelf.detailView.emoKeyboard.textBarView.textView];
    }];
    
    [_bridge registerHandler:@"onUserInfo" handler:^(id data, WVJBResponseCallback responseCallback) {
        //查看用户信息
        [weakSelf creatOterUserCenterVC:data];
    }];
    
    [_bridge registerHandler:@"onThreadThumbsClicked" handler:^(id data, WVJBResponseCallback responseCallback) {
        //查看大图
        weakSelf.picurlArray = [NSMutableArray array];
        NSString *urlstr = (NSString *)data;
        [weakSelf.picurlArray addObject:urlstr];
        // 创建图片浏览
        [[DZWebBrowerHelper sharedHelper] showPhotoImageSources:weakSelf.picurlArray thumImages:weakSelf.picurlArray currentIndex:0 imageContainView:weakSelf.detailView.webView];
    }];
    
    [_bridge registerHandler:@"onthreadContentThumbsClick" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSMutableArray *imgs = [data objectForKey:@"imgs"];
        NSString *urlstr = [data objectForKey:@"url"];
        NSInteger index = [imgs indexOfObject:urlstr];
        if (index >= imgs.count) {
            index = 0;
        }
        [[DZWebBrowerHelper sharedHelper] showPhotoImageSources:imgs thumImages:imgs currentIndex:index imageContainView:weakSelf.detailView.webView];
    }];
    
    [_bridge registerHandler:@"onLoadMore" handler:^(id data, WVJBResponseCallback responseCallback) {
        // 加载更多
    }];
    
    [_bridge registerHandler:@"onSendPoll" handler:^(id data, WVJBResponseCallback responseCallback) {
        // 提交投票
        if (data) {
            [weakSelf createPostVote:data];
        }
    }];
    
    [_bridge registerHandler:@"onVisitVoters" handler:^(id data, WVJBResponseCallback responseCallback) {
        //查看参与投票人
        [weakSelf createVisitVotesrs:data];
    }];
    
    [_bridge registerHandler:@"onSubmit" handler:^(id data, WVJBResponseCallback responseCallback) {
        //参加活动取消活动
        [weakSelf createActivitie:weakSelf.threadModel.isActivity];
    }];
    
    [_bridge registerHandler:@"onComplain" handler:^(id data, WVJBResponseCallback responseCallback) {
        //举报
        [weakSelf createComplain:checkNull(data)];
    }];
    
    [_bridge registerHandler:@"manageActive" handler:^(id data, WVJBResponseCallback responseCallback) {
        [weakSelf manageTheActivity];
    }];
}

#pragma mark  - 参加活动&取消活动
- (void)createActivitie:(BOOL)data{
    
    //    // applied = 1; ：1 活动为存在 已参加或者 审批   button = cancel;  button = join;  有button Key 说明 能参加或者取消     closed = 0;   过期的时候 为 1   "is_ex" = 0; 过期的时候为 1
    
    if (self.threadModel.isActivity) {
        //参加活动
        [[DZMobileCtrl sharedCtrl] PushToPartInActivityController:self.threadModel];
    } else {
        NSString *message = @"确定取消报名？";
        NSString *donetip = @"确定";
        [UIAlertController alertTitle:@"提示" message:message controller:self doneText:donetip cancelText:@"取消" doneHandle:^{
            [self cancelActivity];
        } cancelHandle:nil];
    }
}

- (void)manageTheActivity {
    [[DZMobileCtrl sharedCtrl] PushToActivityEditController:self.threadModel];
}

- (void)cancelActivity {
    
    //取消活动
    [self.HUD showLoadingMessag:@"正在加载" toView:self.view];
    [DZPostNetTool DZ_CancelPostedActivity:self.tid Thread:self.threadModel completion:^(DZBaseResModel *resModel, NSError *error) {
        [self.HUD hide];
        if (resModel) {
            [MBProgressHUD showInfo:resModel.Message.messagestr];
            if (resModel.Message && resModel.Message.isSuccessed) {
                self.currentPageId = 1;
                [self newDownLoadData];
                return;
            }
        }else{
            [self showServerError:error];
        }
    }];
}


#pragma mark  - 举报
-(void)createComplain:(NSString *)jvbaoId{
    if (![self isLogin]) {
        return;
    }
    jvbaoId = jvbaoId.length ? jvbaoId : self.threadModel.pid;
    [DZThreadTool PostComplainWithCtrl:self jvbaoId:jvbaoId fid:self.threadModel.fid];
}

- (void)loginedReshData {
    self.currentPageId = 1;
    [self newDownLoadData];
}

#pragma mark  - 查看参与投票人
-(void)createVisitVotesrs:(id)data {
    [[DZMobileCtrl sharedCtrl] PushToVisitVotersController:self.tid];
}

#pragma mark  -  查看用户详情
-(void)creatOterUserCenterVC:(id)data{
    if (![self isLogin]) {
        return;
    }
    
    if ([DataCheck isValidString:data]) {
        [[DZMobileCtrl sharedCtrl] PushToOtherUserController:checkNull(data)];
    }
}

#pragma  mark  -  参与投票
- (void)createPostVote:(id)data {
    if (![self isLogin]) {
        return;
    }
    if (![DataCheck isValidString:data]) {
        [MBProgressHUD showInfo:@"请选择投票选项"];
        return;
    }
    [DZPostNetTool DZ_PubLishVoteWithData:data fid:self.threadModel.fid tid:self.tid completion:^(DZBaseResModel *resModel, NSError *error) {
        if (resModel) {
            if (resModel.Message && resModel.Message.isSuccessed) {
                [UIAlertController alertTitle:@"投票成功"
                                      message:@"是否查看投票结果"
                                   controller:self
                                     doneText:@"确定"
                                   cancelText:@"取消"
                                   doneHandle:^{
                    [self newDownLoadData];
                } cancelHandle:nil];
            } else {
                [MBProgressHUD showInfo:resModel.Message.messagestr];
            }
        }else{
            [self showServerError:error];
        }
    }];
}


#pragma  mark  -  获取引用回复的内容包括HTML标签
- (void)ReferenceReply:(id)data textview:(YYTextView *)view {
    if (![self isLogin]) {
        return;
    }
    [view becomeFirstResponder];
    
    _reppid = checkNull(data);
    KWEAKSELF
    [DZPostNetTool DZ_ReferenceReply:_reppid tid:self.tid completion:^(DZBaseResModel *resModel,NSString * notice,NSError *error) {
        if (resModel) {
            if (resModel.Message.messagestr.length) {
                [MBProgressHUD showInfo:resModel.Message.messagestr];
            }
            weakSelf.isReferenceReply = YES;
            weakSelf.noticetrimstr = notice;
        }else{
            [weakSelf showServerError:error];
        }
    }];
}

#pragma  mark  -  点赞
-(void)createPraise:(id)data {
    if (![self isLogin]) {
        return;
    }
    if ([self.threadModel.recommend isEqualToString:@"1"]) {
        [MBProgressHUD showInfo:@"您已赞过该主题"];
    } else {
        [DZForumTool DZ_PraiseRequestTid:self.threadModel.tid successBlock:^{
            [self.HUD hide];
            [self.detailView.emoKeyboard.textBarView.praiseBtn setBackgroundImage:[UIImage imageNamed:@"bar_zans"] forState:UIControlStateNormal];
            self.threadModel.recommend = @"1";
            [self.detailView.webView evaluateJavaScript:@"onPraiseSuccess()" completionHandler:nil];
        } failureBlock:^(NSError *error) {
            [self.HUD hide];
            [self showServerError:error];
        }];
    }
}

#pragma  mark  -  分享
- (void)shareBarClick:(UIButton *)sender {
    [self shareSome];
}

- (void)shareSome {
    NSMutableArray * imageArray = [[NSMutableArray alloc] init];
    if ([DataCheck isValidString:self.threadModel.shareImageUrl]) {
        [imageArray addObject:self.threadModel.shareImageUrl];
    }else{
        NSString *iconName = [DZDevice getIconName];
        [imageArray addObject:[UIImage imageNamed:iconName]];
    }
    NSString *dateline = self.threadModel.dateline;
    NSString *authorname = self.threadModel.author;
    NSString *shareContent = [NSString stringWithFormat:@"作者：%@ 发表于：%@",authorname,dateline];
    [[DZShareCenter shareInstance] shareText:shareContent
                                   andImages:imageArray
                                   andUrlstr:self.threadModel.shareUrl
                                    andTitle:self.threadModel.subject
                                     andView:self.view
                                      andHUD:self.HUD];
}

#pragma mark - 帖子收藏
-(void)rightBarClick:(UIButton*)btn {
    
    if (![self isLogin]) {
        return;
    }
    if (btn.tag == 100001) {
        [DZForumTool DZ_CollectionThread:self.tid success:^{
            [self.HUD hide];
            [self setIsCollection:btn];
        } failure:nil];
    } else if (btn.tag==100002) {
        [DZForumTool DZ_DeleCollection:self.tid type:collectThread success:^{
            [self setNotCollection:btn];
        } failure:nil];
    }
}

// 设置收藏的状态
- (void)setNotCollection:(UIButton *)btn {
    [btn setBackgroundImage:[UIImage imageNamed:@"bar_xing"] forState:UIControlStateNormal];
    btn.tag=100001;
}

- (void)setIsCollection:(UIButton *)btn {
    [btn setBackgroundImage:[UIImage imageNamed:@"bar_xings"] forState:UIControlStateNormal];
    btn.tag=100002;
}

#pragma mark - 验证码
- (void)downlodyan {
    
    [self.verifyView downSeccode:@"post" success:^{
        if (self.verifyView.isyanzhengma) {
            [self.verifyView show];
        } else {
            [self postReplay];
        }
    } failure:^(NSError *error) {
        [self showServerError:error];
    }];
    
    KWEAKSELF;
    self.verifyView.submitBlock = ^{
        [weakSelf postReplay];
    };
}


#pragma mark  -  下载数据
-(void)newDownLoadData {
    static NSInteger requestCount = 0;
    self.threadModel.tid = self.tid;
    if (self.currentPageId == 1) {
        [self.HUD showLoadingMessag:@"正在加载" toView:self.view];
    }
    [[DZPostNetTool sharedTool] DZ_DownloadPostDetail:self.tid Page:self.currentPageId success:^(DZPosResModel *resModel,NSDictionary *resDict,NSError *error) {
        if (resModel) {
            requestCount = 0;
            if (resModel.Message && !resModel.Message.isAuthorized) {
                [UIAlertController alertTitle:nil message:resModel.Message.messagestr  controller:self doneText:@"知道了" cancelText:nil doneHandle:^{
                    [self.navigationController popViewControllerAnimated:YES];
                } cancelHandle:nil];
                [self.HUD hide];
                return;
            }
            
            [self emptyHide];
            self.threadModel.currentPage = self.currentPageId;
            [self.threadModel updateModel:resModel res:resDict];
            
            if (self.currentPageId == 1) {
                [self.detailView.webView.scrollView.mj_header endRefreshing];
                [self.detailView.webView.scrollView.mj_footer resetNoMoreData];
                NSString *forumnames = resModel.Variables.thread.forumnames;
                if ([DataCheck isValidString:forumnames]) {
                    self.title = forumnames;
                }
                if ([DZLoginModule isLogged]) {
                    if ([self.threadModel.favorited isEqualToString:@"1"]) {
                        [self setIsCollection:self.detailView.emoKeyboard.textBarView.collectionBtn];
                        
                    } else {
                        [self setNotCollection:self.detailView.emoKeyboard.textBarView.collectionBtn];
                    }
                    
                    if ([self.threadModel.recommend isEqualToString:@"1"]) {
                        [self.detailView.emoKeyboard.textBarView.praiseBtn setBackgroundImage:[UIImage imageNamed:@"bar_zans"] forState:UIControlStateNormal];
                    }
                }
                self.threadModel.isRequest = YES;
                if (self.threadModel.replies + 1 <= self.threadModel.ppp) {
                    [self.detailView.webView.scrollView.mj_footer endRefreshingWithNoMoreData];
                }
                [self.detailView.webView loadBaseWebUrl:self.threadModel.baseUrl.absoluteString back:nil];
            } else {
                [self.detailView.webView.scrollView.mj_footer endRefreshing];
                if (!resModel.Variables.postlist.count){
                    self.currentPageId --;
                    [MBProgressHUD showInfo:@"没有更多的帖子了"];
                    [self.detailView.webView.scrollView.mj_footer endRefreshingWithNoMoreData];
                    return;
                }
                // 下一页json字符串
                NSString *addJsonStr= [[NSString alloc] initWithData:self.threadModel.jsonData encoding:NSUTF8StringEncoding];
                // 加载评论 true 是否时分页
                [self.detailView.webView evaluateJavaScript:[NSString stringWithFormat:@"onLoadReply(%@,true)",addJsonStr] completionHandler:nil];
                if(self.threadModel.replies  < self.threadModel.ppp * (self->_currentPageId)){
                    if (self.currentPageId > 0) {
                        [self.detailView.webView.scrollView.mj_footer endRefreshingWithNoMoreData];
                        self.currentPageId --;
                    }
                }
            }
        } else {
            [self.detailView.webView.scrollView.mj_header endRefreshing];
            [self.detailView.webView.scrollView.mj_footer endRefreshing];
            if (requestCount == 0) {
                [self newDownLoadData];
                requestCount ++;
            } else {
                if (self.currentPageId > 1) {
                    self.currentPageId --;
                }else {
                    [self emptyShow];
                }
                self.threadModel.currentPage = self.currentPageId;
                [self.HUD hide];
                [self showServerError:error];
            }
        }
        
    }];
}

// 页面加载完成之后调用
- (void)dz_mainwebView:(DZBaseWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
    if ([webView.URL.absoluteString isEqualToString:self.threadModel.baseUrl.absoluteString]) {
        if (self.currentPageId == 1) {
            NSString *jsonStr = [[NSString alloc] initWithData:self.threadModel.jsonData encoding:NSUTF8StringEncoding];
            BOOL activitie = NO;
            if ([DataCheck isValidString:self.threadModel.specialString] && [self.threadModel.specialString isEqualToString:@"4"]) {
                activitie= YES;
            }
            if (self.threadModel.isRequest == YES) {
                NSString *isNoimgMode = [[DZMobileCtrl sharedCtrl] isGraphFree] ? @"false" : @"true";
                if (activitie) {
                    [webView evaluateJavaScript:[NSString stringWithFormat: @"onRefresh(%@,%@,%@)",jsonStr,self.threadModel.isActivity?@"false":@"true",isNoimgMode] completionHandler:nil];
                }else {
                    [webView evaluateJavaScript:[NSString stringWithFormat: @"onRefresh(%@,true,%@)",jsonStr,isNoimgMode] completionHandler:nil];
                }
                self.threadModel.isRequest = NO;
            }
            [self.HUD hide];
        }
    }
}

- (void)emptyShow {
    self.emptyView.hidden = NO;
    self.emptyView.frame = self.view.bounds;
    self.detailView.emoKeyboard.hidden = YES;
    self.detailView.webView.scrollView.mj_footer.hidden = YES;
}

- (void)emptyHide {
    self.emptyView.hidden = YES;
    self.detailView.emoKeyboard.hidden = NO;
    self.detailView.webView.scrollView.mj_footer.hidden = NO;
}


#pragma mark - 回复帖子
-(void)postReplay{
    if (![self isLogin]) {
        return;
    }
    //    if ([DataCheck isValidString:self.threadModel.allowpost]&&[self.threadModel.allowpost isEqualToString:@"0"]) {
    //        [MBProgressHUD showInfo:@"暂无发帖权限"];
    //        return;
    //    }
    //begain回复
    
    if (![DataCheck isValidString:self.detailView.emoKeyboard.textBarView.textView.text]) {
        [UIAlertController alertTitle:@"请不要回复空帖" message:nil controller:self doneText:@"OK" cancelText:nil doneHandle:nil cancelHandle:nil];
        [self.detailView.emoKeyboard.textBarView.textView resignFirstResponder];
        return;
    }
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:self.detailView.emoKeyboard.textBarView.textView.text forKey:@"message"];
    [dic setObject:[DZMobileCtrl sharedCtrl].Global.formhash forKey:@"formhash"];
    [dic setObject:self.threadModel.tid  forKey:@"tid"];
    // 引用回复 post 增加 两个参数
    if (_isReferenceReply) {
        [dic setObject:_noticetrimstr forKey:@"noticetrimstr"];
        [dic setObject:_reppid forKey:@"reppid"];
    }
    
    if (self.verifyView.isyanzhengma) {
        [dic setObject:self.verifyView.yanTextField.text forKey:@"seccodeverify"];
        [dic setObject:self.verifyView.secureData.sechash forKey:@"sechash"];
        if (self.verifyView.secureData.secqaa.length) {
            [dic setObject:self.verifyView.secTextField.text forKey:@"secanswer"];
        }
    }
    
    if (self.preSalkey) {
        [dic setObject:self.preSalkey forKey:@"saltkey"];
    }
    
    NSArray *aidArr = self.detailView.emoKeyboard.uploadView.uploadModel.aidArray;
    if (aidArr.count > 0) {
        for (int i=0; i < aidArr.count; i++){
            NSString *description = @"";
            [dic setObject:description forKey:[NSString stringWithFormat:@"attachnew[%@][description]",[aidArr objectAtIndex:i]]];
        }
    }
    
    [self sendReply:dic];
}

- (void)sendReply:(NSDictionary *)dic {
    
    KWEAKSELF
    [self.HUD showLoadingMessag:@"发帖中..." toView:self.view];
    [DZPostNetTool DZ_SendPostReply:dic completion:^(DZBaseResModel *resModel, NSError *error) {
        [self.HUD hide];
        if (resModel) {
            if (resModel.Message) {
                if (resModel.Message.isSuccessed) {
                    weakSelf.isReferenceReply = NO;
                    [self.detailView.emoKeyboard clearData];
                    if (![resModel.Message.messagestr containsString:@"审核"]) {
                        [MBProgressHUD showInfo:@"回帖成功"];
                        if (weakSelf.currentPageId==1) {
                            if (self.threadModel.replies + 1 < self.threadModel.ppp - 1) {
                                //  [self.detailView.webView evaluateJavaScript:[NSString stringWithFormat:@"onDiscussSuccess(%@,true,%@,%@)",_strJSONData,self.isnoimage,pid] completionHandler:nil];
                                //  [self.detailView.webView evaluateJavaScript:[NSString stringWithFormat:@"onLoadReply(%@,true)",_strJSONData] completionHandler:nil];
                                [self newDownLoadData];
                            }
                        }
                    } else {
                        [MBProgressHUD showInfo:resModel.Message.messagestr];
                    }
                }else{
                    [MBProgressHUD showInfo:resModel.Message.messagestr];
                    if ([resModel.Message.messageval isEqualToString:@"post_sm_isnull"]) {
                        self.detailView.emoKeyboard.textBarView.textView.text = nil;
                    }
                }
            }else{
                [MBProgressHUD showInfo:@"回帖失败"];
            }
        }else{
            [self showServerError:error];
        }
    }];
}

#pragma mark 点击状态栏到顶部
- (void)statusBarTappedAction:(NSNotification*)notification {
    [self.detailView.webView.scrollView setContentOffset:CGPointMake(0,0) animated:YES];
}

#pragma mark - 滚动webView的时候收起键盘
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self.detailView.emoKeyboard hideCustomerKeyBoard];
}

#pragma mark -  键盘代理发送sendAction
-(void)sendAction{
    
    [self.detailView.emoKeyboard hideCustomerKeyBoard];
    if (![self isLogin]) {
        return;
    }
    [self downlodyan];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark   /********************* 初始化 *************************/

- (DZSecVerifyView *)verifyView {
    if (!_verifyView) {
        _verifyView = [[DZSecVerifyView alloc] init];
    }
    return _verifyView;
}

- (DZThreadModel *)threadModel {
    if (!_threadModel) {
        _threadModel = [[DZThreadModel alloc] init];
    }
    return _threadModel;
}

- (ThreadDetailView *)detailView{
    if (!_detailView) {
        _detailView = [[ThreadDetailView alloc] initWithFrame:KView_OutNavi_Bounds];
        // 设置代理
        _detailView.webView.WKBaseDelegate = self;
        _detailView.webView.scrollView.delegate = self;
        UIPinchGestureRecognizer *gestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchAction:)];
        [_detailView.webView addGestureRecognizer:gestureRecognizer];
        UITapGestureRecognizer *tapges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
        tapges.delegate = self;
        [_detailView.webView addGestureRecognizer:tapges];
    }
    return _detailView;
}





@end













