//
//  FKTableViewSectionModel.h
//  FKTableView
//
//  Created by CHAT on 2018/10/18.
//  Copyright © 2018 CHAT. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIColor;
@class FKTableViewHeaderFooterModel;
@interface FKTableSectionHeaderFooterConfig : NSObject
- (instancetype)initWithHeight:(NSUInteger) height headFooterModel:(FKTableViewHeaderFooterModel*) headFooterModel;

@property (nonatomic, readonly) NSUInteger height;
@property (nonatomic, strong, readonly) FKTableViewHeaderFooterModel* headFooterModel;
@end

@class FKTableViewCellModel;
@interface FKTableViewSectionModel : NSObject
- (instancetype)initWithRowModels:(NSArray<FKTableViewCellModel*>*)rowModels headConfig:(FKTableSectionHeaderFooterConfig*) headConfig footConfig:(FKTableSectionHeaderFooterConfig*) footConfig;

@property (nonatomic, strong, readonly) NSArray<FKTableViewCellModel*>* rowModels;
@property (nonatomic, strong, readonly) FKTableSectionHeaderFooterConfig* headConfig;
@property (nonatomic, strong, readonly) FKTableSectionHeaderFooterConfig* footConfig;
@end

