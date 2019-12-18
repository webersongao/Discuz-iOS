//
//  DZUserTableView.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/18.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZUserTableView.h"
#import "DZUserCenterCell.h"
#import "DZLogoutCell.h"

@interface DZUserTableView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) DZUserDataModel *centerModel;  //!< 属性注释

@end

@implementation DZUserTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame style:UITableViewStyleGrouped];
    if (self) {
        [self registerClass:[DZLogoutCell class] forCellReuseIdentifier:@"DZLogoutCell"];
        [self registerClass:[DZUserCenterCell class] forCellReuseIdentifier:@"DZUserCenterCell"];
    }
    return self;
}


-(void)updateUserTableView:(DZUserDataModel *)Model{
    self.centerModel = Model;
    [self reloadData];
}



#pragma mark   /********************* 数据源方法 *************************/

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.centerModel.userDataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray *serctionArray = self.centerModel.userDataArray[section];
    
    return serctionArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TextIconModel *model = self.centerModel.userDataArray[indexPath.section][indexPath.row];
    if (indexPath.section == self.centerModel.userDataArray.count - 1) {
        DZLogoutCell *LogoutCell = [tableView dequeueReusableCellWithIdentifier:@"DZLogoutCell" forIndexPath:indexPath];
        [LogoutCell updateLogoutCell:model.text];
        return LogoutCell;
    }else{
        DZUserCenterCell *CenterCell = [tableView dequeueReusableCellWithIdentifier:@"DZUserCenterCell" forIndexPath:indexPath];
        BOOL isIndicator = NO;
        [CenterCell updateCenterCell:model access:isIndicator];
        return CenterCell;
    }
}


#pragma mark   /********************* 代理方法 *************************/


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return kCellDefaultHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TextIconModel *model = self.centerModel.userDataArray[indexPath.section][indexPath.row];
    if (self.CellTapAction) {
        self.CellTapAction(model);
    }
}





@end










