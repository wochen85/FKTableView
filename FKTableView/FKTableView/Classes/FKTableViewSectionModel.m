//
//  FKTableViewSectionModel.m
//  FKTableView
//
//  Created by CHAT on 2018/10/18.
//  Copyright © 2018 CHAT. All rights reserved.
//

#import "FKTableViewSectionModel.h"

@implementation FKTableSectionHeaderFooterConfig

- (instancetype)initWithHeight:(NSUInteger) height bgColor:(UIColor*) bgColor title:(NSString*) title
{
    self = [super init];
    if (self) {
        _height = height;
        _bgColor = bgColor;
        _title = title;
    }
    return self;
}

@end

@implementation FKTableViewSectionModel
- (FKTableSectionHeaderFooterConfig *)headConfig
{
    if (!_headConfig)
    {
        _headConfig = [[FKTableSectionHeaderFooterConfig alloc] initWithHeight:0.00000001 bgColor:nil title:@""];
    }
    return _headConfig;
}

- (FKTableSectionHeaderFooterConfig *)footConfig
{
    if (!_footConfig)
    {
        _footConfig = [[FKTableSectionHeaderFooterConfig alloc] initWithHeight:0.00000001 bgColor:nil title:@""];
    }
    return _footConfig;
}

- (NSMutableArray<FKTableViewCellModel *> *)rowModels
{
    if (!_rowModels)
    {
        _rowModels = [NSMutableArray array];
    }
    return _rowModels;
}
@end
