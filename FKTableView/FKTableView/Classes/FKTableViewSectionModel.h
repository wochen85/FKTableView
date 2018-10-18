//
//  FKTableViewSectionModel.h
//  FKTableView
//
//  Created by CHAT on 2018/10/18.
//  Copyright © 2018 CHAT. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIColor;
@interface FKTableSectionHeaderFooterConfig : NSObject
@property (nonatomic) NSUInteger height;
@property (nonatomic, strong) UIColor* bgColor;
@property (nonatomic, copy) NSString* title;

- (instancetype)initWithHeight:(NSUInteger) height bgColor:(UIColor*) bgColor title:(NSString*) title;
@end

@class FKTableViewCellModel;
@interface FKTableViewSectionModel : NSObject
@property (nonatomic, strong) NSMutableArray<FKTableViewCellModel*>* rowModels;
@property (nonatomic, strong) FKTableSectionHeaderFooterConfig* headConfig;
@property (nonatomic, strong) FKTableSectionHeaderFooterConfig* footConfig;
@end

