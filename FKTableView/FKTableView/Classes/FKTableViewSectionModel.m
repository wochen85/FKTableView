//
//  FKTableViewSectionModel.m
//  FKTableView
//
//  Created by CHAT on 2018/10/18.
//  Copyright © 2018 CHAT. All rights reserved.
//

#import "FKTableViewSectionModel.h"
#import "FKTableViewHeaderFooterModel.h"

@interface FKTableSectionHeaderFooterConfig()
@property (nonatomic) NSUInteger height;
@property (nonatomic, strong) FKTableViewHeaderFooterModel* headFooterModel;
@end

@implementation FKTableSectionHeaderFooterConfig

- (instancetype)initWithHeight:(NSUInteger) height headFooterModel:(FKTableViewHeaderFooterModel*) headFooterModel
{
    self = [super init];
    if (self) {
        _height = height;
        _headFooterModel = headFooterModel;
    }
    return self;
}

- (FKTableViewHeaderFooterModel *)headFooterModel
{
    if (nil == _headFooterModel)
    {
        _headFooterModel = [FKTableViewHeaderFooterModel new];
    }
    return _headFooterModel;
}

@end

@interface FKTableViewSectionModel()
@property (nonatomic, strong) NSArray<FKTableViewCellModel*>* rowModels;
@property (nonatomic, strong) FKTableSectionHeaderFooterConfig* headConfig;
@property (nonatomic, strong) FKTableSectionHeaderFooterConfig* footConfig;
@end

@implementation FKTableViewSectionModel
- (instancetype)initWithRowModels:(NSArray<FKTableViewCellModel*>*)rowModels headConfig:(FKTableSectionHeaderFooterConfig*) headConfig footConfig:(FKTableSectionHeaderFooterConfig*) footConfig;
{
    self = [super init];
    if (self) {
        _rowModels = rowModels;
        _headConfig = headConfig;
        _footConfig = footConfig;
    }
    return self;
}

- (FKTableSectionHeaderFooterConfig *)headConfig
{
    if (!_headConfig)
    {
        _headConfig = [[FKTableSectionHeaderFooterConfig alloc] initWithHeight:0.00000001 headFooterModel:nil];
    }
    return _headConfig;
}

- (FKTableSectionHeaderFooterConfig *)footConfig
{
    if (!_footConfig)
    {
        _footConfig = [[FKTableSectionHeaderFooterConfig alloc] initWithHeight:0.00000001 headFooterModel:nil];
    }
    return _footConfig;
}

- (NSArray<FKTableViewCellModel *> *)rowModels
{
    if (!_rowModels)
    {
        _rowModels = [NSArray array];
    }
    return _rowModels;
}
@end
