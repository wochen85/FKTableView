//
//  WithoutNibViewController.m
//  FKTableView
//
//  Created by CHAT on 2019/7/11.
//  Copyright © 2019 CHAT. All rights reserved.
//

#import "WithoutNibViewController.h"
#import <FKTableView.h>
#import "BookCellModel.h"
#import <SVProgressHUD.h>
#import "MyBookHeadFootModel.h"
#import "MyBookSectionHeadFootModel.h"

@interface WithoutNibViewController ()
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) NSMutableArray* cellModels;

@property (nonatomic, strong) FKSectionModel* sectionModel;
@end

@implementation WithoutNibViewController
- (NSMutableArray *)cellModels
{
    if (!_cellModels)
    {
        _cellModels = [NSMutableArray array];
    }
    return _cellModels;
}

- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    }
    return _tableView;
}

- (void)dealloc
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.tableView.frame = self.view.bounds;
    
    for (int i=1; i<=7; i++)
    {
        NSString* name = [NSString stringWithFormat:@"name %@", @(i)];
        NSString* author = [NSString stringWithFormat:@"author %@", @(i)];
        BookCellModel* cellModel = [[BookCellModel alloc] initWithName:name author:author];
        [self.cellModels addObject:cellModel];
        [cellModel.clickedSignal subscribeNext:^(id  _Nullable x) {
            [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"点击了第 %@ 行", @(i)]];
        }];
    }
    
    //section头部
    MyBookSectionHeadFootModel* headSectModel = [MyBookSectionHeadFootModel new];
    headSectModel.text = @"Section头部";
    FKSectionHeaderFooterConfig* headConfig = [[FKSectionHeaderFooterConfig alloc] initWithHeight:40 headFooterModel:headSectModel];
    
    //section尾部
    MyBookSectionHeadFootModel* footSectModel = [MyBookSectionHeadFootModel new];
    footSectModel.text = @"Section尾部";
    FKSectionHeaderFooterConfig* footConfig = [[FKSectionHeaderFooterConfig alloc] initWithHeight:40 headFooterModel:footSectModel];
    
    _sectionModel = [[FKSectionModel alloc] initWithRowModels:self.cellModels headConfig:headConfig footConfig:footConfig];
    [self.tableView fk_configSectionModels:@[_sectionModel]];
    
    MyBookHeadFootModel* headModel = [MyBookHeadFootModel new];
    headModel.text = @"表格头部";
    [self.tableView fk_configHeader:headModel height:50];
    
    MyBookHeadFootModel* footModel = [MyBookHeadFootModel new];
    footModel.text = @"表格尾部";
    [self.tableView fk_configFooter:footModel height:50];
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
