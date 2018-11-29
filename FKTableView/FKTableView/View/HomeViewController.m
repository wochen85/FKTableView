//
//  HomeViewController.m
//  FKTableView
//
//  Created by chat on 2018/11/29.
//  Copyright © 2018 CHAT. All rights reserved.
//

#import "HomeViewController.h"
#import "ViewController.h"
#import "SectionViewController.h"
#import "CommonSectionViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"FKTableView";
}

- (IBAction)goNoSection:(UIButton*)sender
{
    ViewController* vc = [ViewController new];
    vc.title = sender.currentTitle;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)goCommonSection:(UIButton*)sender
{
    CommonSectionViewController* vc = [CommonSectionViewController new];
    vc.title = sender.currentTitle;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)goCustomSection:(UIButton*)sender
{
    SectionViewController* vc = [SectionViewController new];
    vc.title = sender.currentTitle;
    [self.navigationController pushViewController:vc animated:YES];
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
