//
//  UITableView+FKExtension.m
//  FKTableView
//
//  Created by CHAT on 2018/10/18.
//  Copyright © 2018 CHAT. All rights reserved.
//

#import "UITableView+FKExtension.h"
#import <objc/runtime.h>
#import "FKCellModel.h"
#import "FKSectionModel.h"
#import "UITableViewCell+FKExtension.h"
#import "UITableViewHeaderFooterView+FKExtension.h"
#import "FKHeaderFooterCommonModel.h"
#import "UIView+FKExtension.h"

@interface UITableView ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSArray<FKSectionModel*>* fk_sectionModels;
@end

@implementation UITableView (FKExtension)

#pragma mark - 存取器

- (NSArray<FKSectionModel *> *)fk_sectionModels
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setFk_sectionModels:(NSArray<FKSectionModel *> *)sectionModels
{
    objc_setAssociatedObject(self, @selector(fk_sectionModels), sectionModels, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void) fk_configRowModels:(NSArray<FKCellModel*>*) rowModels
{
    FKSectionModel* sectionModel = [[FKSectionModel alloc] initWithRowModels:rowModels headConfig:nil footConfig:nil];
    
    self.fk_sectionModels = @[sectionModel];
    self.dataSource = self;
    self.delegate = self;
    [self reloadData];
}

-(void) fk_configSectionModels:(NSArray<FKSectionModel*>*) sectionModels
{
    self.fk_sectionModels = sectionModels;
    self.dataSource = self;
    self.delegate = self;
    [self reloadData];
}

-(void) fk_configHeader:(nullable FKViewModel*) headerModel height:(CGFloat) height
{
    if (!headerModel)
    {
        self.tableHeaderView = [UIView new];
        return;
    }
    
    NSString* nibPath = [[NSBundle mainBundle] pathForResource:headerModel.nibOrClassName ofType:@"nib"];
    UIView* view = nil;
    if (nibPath)
    {
        NSArray* viewArr = [[NSBundle mainBundle] loadNibNamed:headerModel.nibOrClassName owner:nil options:nil];
        if (viewArr.count)
        {
            view = viewArr[0];
        }
        else
        {
            view = [NSClassFromString(headerModel.nibOrClassName) new];
        }
    }
    else
    {
        view = [NSClassFromString(headerModel.nibOrClassName) new];
    }
    
    view.frame = CGRectMake(0, 0, 0, height);
    self.tableHeaderView = view;
    self.tableHeaderView.clipsToBounds = YES;
    [self.tableHeaderView fk_bindModel:headerModel];
}

-(void) fk_configFooter:(FKViewModel*) footerModel height:(CGFloat) height
{
    if (!footerModel)
    {
        self.tableFooterView = [UIView new];
        return;
    }
    NSString* nibPath = [[NSBundle mainBundle] pathForResource:footerModel.nibOrClassName ofType:@"nib"];
    UIView* view = nil;
    if (nibPath)
    {
        NSArray* viewArr = [[NSBundle mainBundle] loadNibNamed:footerModel.nibOrClassName owner:nil options:nil];
        if (viewArr.count)
        {
            view = viewArr[0];
        }
        else
        {
            view = [NSClassFromString(footerModel.nibOrClassName) new];
        }
    }
    else
    {
        view = [NSClassFromString(footerModel.nibOrClassName) new];
    }
    view.frame = CGRectMake(0, 0, 0, height);
    self.tableFooterView = view;
    self.tableHeaderView.clipsToBounds = YES;
    [self.tableFooterView fk_bindModel:footerModel];
}

#pragma mark - 数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.fk_sectionModels.count;
}

-(FKCellModel*) rowModel:(NSIndexPath*)indexPath
{
    return self.fk_sectionModels[indexPath.section].rowModels[indexPath.row];
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.fk_sectionModels[section].rowModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [UITableViewCell fk_cellForTableView:tableView cellModel:[self rowModel:indexPath]];
}

#pragma clang diagnostic pop

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[self rowModel:indexPath].selectedSignal sendNext:[self rowModel:indexPath]];
    });
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return self.fk_sectionModels[section].headConfig.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return self.fk_sectionModels[section].footConfig.height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [UITableViewHeaderFooterView fk_headerFooterForTableView:tableView headerFooterModel:self.fk_sectionModels[section].headConfig.headFooterModel];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UITableViewHeaderFooterView fk_headerFooterForTableView:tableView headerFooterModel:self.fk_sectionModels[section].footConfig.headFooterModel];
}


@end
