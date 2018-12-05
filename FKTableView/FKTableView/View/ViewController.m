//
//  ViewController.m
//  FKTableView
//
//  Created by CHAT on 2018/10/18.
//  Copyright © 2018 CHAT. All rights reserved.
//

#import "ViewController.h"
#import "FKPersonCellModel.h"
#import "FKPersonViewModel.h"
#import <UIScrollView+FreshEmpty.h>
#import <FKTableView.h>
#import "MyTableHeadFootModel.h"

@interface ViewController ()
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) FKPersonViewModel* viewModel;
@end

@implementation ViewController

- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    }
    return _tableView;
}

- (FKPersonViewModel *)viewModel
{
    if (!_viewModel)
    {
        _viewModel = [FKPersonViewModel new];
    }
    return _viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configSubViews];
    [self initRAC];
    [self configFresh];
    
    [RACObserve(self.viewModel, cellModelArr) subscribeNext:^(id  _Nullable x) {
        [self.tableView fk_configRowModels:self.viewModel.cellModelArr];
    }];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"切换头部" style:(UIBarButtonItemStylePlain) target:self action:@selector(changeHead)];
}

-(void) changeHead
{
    static BOOL flag = NO;
    if (flag)
    {
        MyTableHeadFootModel* headModel = [MyTableHeadFootModel new];
        headModel.labelText = @"tableHead";
        headModel.segmentIndex = 0;
        headModel.buttonText = @"头部操作";
        [self.tableView fk_configHeader:headModel];
        self.tableView.tableHeaderView.frame = CGRectMake(0, 0, 0, 110);
    }
    else
    {
        [self.tableView fk_configHeader:nil];
    }
    flag = !flag;
}

-(void) configFresh
{
    [self.tableView configFresh:^{
        [[self.viewModel fresh] subscribeNext:^(id  _Nullable x) {
            [self.tableView endFresh];
        }];
    }];
    
    [self.tableView configLoadMore:^{
        [[self.viewModel loadMore] subscribeNext:^(id  _Nullable x) {
            [self.tableView endLoadMore:NO];
        }];
    }];
    [self.tableView beginFresh];
}

- (void) initRAC
{
    [self.viewModel.showFullNameSignal subscribeNext:^(NSString * _Nullable x) {
        UIAlertController* alc = [UIAlertController alertControllerWithTitle:@"提示" message:x preferredStyle:UIAlertControllerStyleAlert];
        [alc addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alc animated:YES completion:nil];
    }];
}

-(void) configSubViews
{
    [self.view addSubview:self.tableView];
    self.tableView.frame = self.view.bounds;
    
    [self.tableView fk_configRowModels:self.viewModel.cellModelArr];
    
    
    MyTableHeadFootModel* headModel = [MyTableHeadFootModel new];
    headModel.labelText = @"tableHead";
    headModel.segmentIndex = 0;
    headModel.buttonText = @"头部操作";
    [self.tableView fk_configHeader:headModel];
    self.tableView.tableHeaderView.frame = CGRectMake(0, 0, 0, 110);
    
    MyTableHeadFootModel* footModel = [MyTableHeadFootModel new];
    footModel.labelText = @"tableFoot";
    footModel.segmentIndex = 1;
    footModel.buttonText = @"尾部操作";
    [self.tableView fk_configFooter:footModel];
    self.tableView.tableFooterView.frame = CGRectMake(0, 0, 0, 110);
}


@end
