//
//  SettingViewController.m
//  FKTableView
//
//  Created by CHAT on 2019/7/18.
//  Copyright © 2019 CHAT. All rights reserved.
//

#import "SettingViewController.h"
#import "TextSettingCellModel.h"
#import "SwitchSettingCellModel.h"
#import <Masonry.h>
#import <FKTableView.h>
#import <SVProgressHUD.h>

@interface SettingViewController ()
@property (nonatomic, strong) UITableView* tablewView;
@end

@implementation SettingViewController

- (UITableView *)tablewView
{
    if (!_tablewView)
    {
        _tablewView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tablewView.tableFooterView = [UIView new];
    }
    return _tablewView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    [self configTableView];
}

- (void) configTableView
{
    [self.view addSubview:self.tablewView];
    [self.tablewView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    //编辑资料
    TextSettingCellModel* editProfileCellModel = [[TextSettingCellModel alloc] initWithText:@"编辑资料"];
    [editProfileCellModel.selectedSignal subscribeNext:^(FKCellModel * _Nullable x) {
        [SVProgressHUD showInfoWithStatus:@"你点击了\"编辑资料\""];
    }];
    //账号和隐私设置
    TextSettingCellModel* accountCellModel = [[TextSettingCellModel alloc] initWithText:@"账号和隐私设置"];
    [accountCellModel.selectedSignal subscribeNext:^(FKCellModel * _Nullable x) {
        [SVProgressHUD showInfoWithStatus:@"你点击了\"账号和隐私设置\""];
    }];
    //黑名单
    TextSettingCellModel* blackListCellModel = [[TextSettingCellModel alloc] initWithText:@"黑名单"];
    [blackListCellModel.selectedSignal subscribeNext:^(FKCellModel * _Nullable x) {
        [SVProgressHUD showInfoWithStatus:@"你点击了\"黑名单\""];
    }];
    //夜间模式
    SwitchSettingCellModel* nightModeCellModel = [[SwitchSettingCellModel alloc] initWithText:@"夜间模式" switchOn:NO];
    [nightModeCellModel.switchChangeSignal subscribeNext:^(NSNumber * _Nullable x) {
        [SVProgressHUD showInfoWithStatus:x.boolValue?@"夜间模式 打开":@"夜间模式 关闭"];
    }];
    
//    [self.tablewView fk_configRowModels:@[editProfileCellModel, accountCellModel, blackListCellModel, nightModeCellModel]];
    FKHeaderFooterCommonModel* basicSectionHeaderModel = [[FKHeaderFooterCommonModel alloc] initWithText:[[NSAttributedString alloc] initWithString:@"基本设置"] bgColor:[UIColor clearColor] textAlignment:NSTextAlignmentCenter];
    [basicSectionHeaderModel.clickSignal subscribeNext:^(id  _Nullable x) {
        [SVProgressHUD showInfoWithStatus:@"你点击了基本设置"];
    }];
    FKSectionHeaderFooterConfig* basicSectionHeadConfig = [[FKSectionHeaderFooterConfig alloc] initWithHeight:40 headFooterModel:basicSectionHeaderModel];
    FKSectionModel* basicSectionModel = [[FKSectionModel alloc] initWithRowModels:@[editProfileCellModel, accountCellModel] headConfig:basicSectionHeadConfig footConfig:nil];
    
    FKHeaderFooterCommonModel* otherSectionHeaderModel = [[FKHeaderFooterCommonModel alloc] initWithText:[[NSAttributedString alloc] initWithString:@"其他设置"] bgColor:[UIColor clearColor] textAlignment:NSTextAlignmentCenter];
    [otherSectionHeaderModel.clickSignal subscribeNext:^(id  _Nullable x) {
        [SVProgressHUD showInfoWithStatus:@"你点击了其他设置"];
    }];
    FKSectionHeaderFooterConfig* otherSectionHeadConfig = [[FKSectionHeaderFooterConfig alloc] initWithHeight:40 headFooterModel:otherSectionHeaderModel];
    FKSectionModel* otherSectionModel = [[FKSectionModel alloc] initWithRowModels:@[blackListCellModel, nightModeCellModel] headConfig:otherSectionHeadConfig footConfig:nil];
    
    [self.tablewView fk_configSectionModels:@[basicSectionModel, otherSectionModel]];
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
