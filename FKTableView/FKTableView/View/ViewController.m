//
//  ViewController.m
//  FKTableView
//
//  Created by CHAT on 2018/10/18.
//  Copyright © 2018 CHAT. All rights reserved.
//

#import "ViewController.h"
#import "FKPersonCellModel.h"
#import "UITableView+FKExtension.h"
#import "FKPersonViewModel.h"
#import <UIScrollView+FreshEmpty.h>

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
        [self.tableView configRowModels:self.viewModel.cellModelArr];
    }];
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
    
    [self.tableView configRowModels:self.viewModel.cellModelArr];
}


@end
