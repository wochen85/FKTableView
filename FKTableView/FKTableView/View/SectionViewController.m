//
//  SectionViewController.m
//  FKTableView
//
//  Created by CHAT on 2018/10/18.
//  Copyright © 2018 CHAT. All rights reserved.
//

#import "SectionViewController.h"
#import "FKPersonCellModel.h"
#import "FKPersonViewModel.h"
#import <FKTableView.h>

@interface SectionViewController ()
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) FKPersonViewModel* viewModel;
@end

@implementation SectionViewController

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
    
    [self.tableView fk_configSectionModels:self.viewModel.sectionModelArr];
}

@end
