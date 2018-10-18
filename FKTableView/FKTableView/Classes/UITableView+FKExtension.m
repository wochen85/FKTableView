//
//  UITableView+FKExtension.m
//  FKTableView
//
//  Created by CHAT on 2018/10/18.
//  Copyright © 2018 CHAT. All rights reserved.
//

#import "UITableView+FKExtension.h"
#import <objc/runtime.h>
#import "FKTableViewCellModel.h"
#import "FKTableViewSectionModel.h"
#import "UITableViewCell+FKExtension.h"

@interface UITableView ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSArray<FKTableViewSectionModel*>* sectionModels;
@end

@implementation UITableView (FKExtension)

#pragma mark - 存取器

- (NSArray<FKTableViewSectionModel *> *)sectionModels
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setSectionModels:(NSArray<FKTableViewSectionModel *> *)sectionModels
{
    objc_setAssociatedObject(self, @selector(sectionModels), sectionModels, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void) configRowModels:(NSArray<FKTableViewCellModel*>*) rowModels
{
    FKTableViewSectionModel* sectionModel = [FKTableViewSectionModel new];
    [sectionModel.rowModels removeAllObjects];
    [sectionModel.rowModels addObjectsFromArray:rowModels];
    
    self.sectionModels = @[sectionModel];
    self.dataSource = self;
    self.delegate = self;
}

-(void) configSectionModels:(NSArray<FKTableViewSectionModel*>*) sectionModels
{
    self.sectionModels = sectionModels;
    self.dataSource = self;
    self.delegate = self;
}

#pragma mark - 数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sectionModels.count;
}

-(FKTableViewCellModel*) rowModel:(NSIndexPath*)indexPath
{
    return self.sectionModels[indexPath.section].rowModels[indexPath.row];
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sectionModels[section].rowModels.count;
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
    return self.sectionModels[section].headConfig.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return self.sectionModels[section].footConfig.height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView* v = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    if (!v)
    {
        v = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"header"];
    }
    return v;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UITableViewHeaderFooterView* v = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"footer"];
    if (!v)
    {
        v = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"footer"];
    }
    return v;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    if ([view isKindOfClass:[UITableViewHeaderFooterView class]]) {
        ((UITableViewHeaderFooterView *)view).backgroundView.backgroundColor = self.sectionModels[section].headConfig.bgColor?:[UIColor clearColor];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section
{
    if ([view isKindOfClass:[UITableViewHeaderFooterView class]]) {
        ((UITableViewHeaderFooterView *)view).backgroundView.backgroundColor = self.sectionModels[section].footConfig.bgColor?:[UIColor clearColor];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.sectionModels[section].headConfig.title;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return self.sectionModels[section].footConfig.title;
}

@end