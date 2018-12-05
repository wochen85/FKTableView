//
//  FKTableViewSectionModel.m
//  FKTableView
//
//  Created by CHAT on 2018/10/18.
//  Copyright © 2018 CHAT. All rights reserved.
//

#import "FKSectionModel.h"
#import "FKHeaderFooterModel.h"

@interface FKSectionHeaderFooterConfig()
@property (nonatomic) NSUInteger height;
@property (nonatomic, strong) FKHeaderFooterModel* headFooterModel;
@end

@implementation FKSectionHeaderFooterConfig

- (instancetype)initWithHeight:(NSUInteger) height headFooterModel:(FKHeaderFooterModel*) headFooterModel
{
    self = [super init];
    if (self) {
        _height = height;
        _headFooterModel = headFooterModel;
    }
    return self;
}

- (FKHeaderFooterModel *)headFooterModel
{
    if (nil == _headFooterModel)
    {
        _headFooterModel = [FKHeaderFooterModel new];
    }
    return _headFooterModel;
}

@end

@interface FKSectionModel()
@property (nonatomic, strong) NSArray<FKCellModel*>* rowModels;
@property (nonatomic, strong) FKSectionHeaderFooterConfig* headConfig;
@property (nonatomic, strong) FKSectionHeaderFooterConfig* footConfig;
@end

@implementation FKSectionModel
- (instancetype)initWithRowModels:(NSArray<FKCellModel*>*)rowModels headConfig:(FKSectionHeaderFooterConfig*) headConfig footConfig:(FKSectionHeaderFooterConfig*) footConfig;
{
    self = [super init];
    if (self) {
        _rowModels = rowModels;
        _headConfig = headConfig;
        _footConfig = footConfig;
    }
    return self;
}

- (FKSectionHeaderFooterConfig *)headConfig
{
    if (!_headConfig)
    {
        _headConfig = [[FKSectionHeaderFooterConfig alloc] initWithHeight:0.00000001 headFooterModel:nil];
    }
    return _headConfig;
}

- (FKSectionHeaderFooterConfig *)footConfig
{
    if (!_footConfig)
    {
        _footConfig = [[FKSectionHeaderFooterConfig alloc] initWithHeight:0.00000001 headFooterModel:nil];
    }
    return _footConfig;
}

- (NSArray<FKCellModel *> *)rowModels
{
    if (!_rowModels)
    {
        _rowModels = [NSArray array];
    }
    return _rowModels;
}
@end
