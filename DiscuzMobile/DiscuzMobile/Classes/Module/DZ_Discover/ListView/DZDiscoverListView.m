//
//  DZDiscoverListView.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/22.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZDiscoverListView.h"

@interface DZDiscoverListView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataArray;  //!< 属性注释

@end

@implementation DZDiscoverListView

- (instancetype)initWithListFrame:(CGRect)frame{
    self = [super initWithFrame:frame style:UITableViewStyleGrouped];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[DZThreadListCell class] forCellReuseIdentifier:@"DZThreadListCell"];
    }
    return self;
}

-(void)updateListView:(NSArray *)array{
    self.dataArray = array.copy;
    [self reloadData];
}


#pragma mark   /********************* 数据源 *************************/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *sectionArr = self.dataArray[section];
    return sectionArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DZThreadListModel *cellModel  = self.dataArray[indexPath.section][indexPath.row];
    DZThreadListCell *listCell = [tableView dequeueReusableCellWithIdentifier:@"DZThreadListCell" forIndexPath:indexPath];
    
    [listCell updateThreadCell:cellModel isTop:((indexPath.section == 0) ? YES : NO)];
    return listCell;
}



#pragma mark   /********************* 代理方法 *************************/

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    DZThreadListModel *cellModel  = self.dataArray[indexPath.section][indexPath.row];
    return cellModel.listLayout.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}




@end
