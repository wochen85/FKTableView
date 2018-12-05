//
//  FKTableViewSectionModel.h
//  FKTableView
//
//  Created by CHAT on 2018/10/18.
//  Copyright © 2018 CHAT. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIColor;
@class FKHeaderFooterModel;
@interface FKSectionHeaderFooterConfig : NSObject
- (instancetype)initWithHeight:(NSUInteger) height headFooterModel:(FKHeaderFooterModel*) headFooterModel;

@property (nonatomic, readonly) NSUInteger height;
@property (nonatomic, strong, readonly) FKHeaderFooterModel* headFooterModel;
@end

@class FKCellModel;
@interface FKSectionModel : NSObject
- (instancetype)initWithRowModels:(NSArray<FKCellModel*>*)rowModels headConfig:(FKSectionHeaderFooterConfig*) headConfig footConfig:(FKSectionHeaderFooterConfig*) footConfig;

@property (nonatomic, strong, readonly) NSArray<FKCellModel*>* rowModels;
@property (nonatomic, strong, readonly) FKSectionHeaderFooterConfig* headConfig;
@property (nonatomic, strong, readonly) FKSectionHeaderFooterConfig* footConfig;
@end

