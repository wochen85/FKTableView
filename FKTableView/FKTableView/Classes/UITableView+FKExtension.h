//
//  UITableView+FKExtension.h
//  FKTableView
//
//  Created by CHAT on 2018/10/18.
//  Copyright © 2018 CHAT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FKTableViewCellModel;
@class FKTableViewSectionModel;
@interface UITableView (FKExtension)
-(void) configRowModels:(NSArray<FKTableViewCellModel*>*) rowModels;
-(void) configSectionModels:(NSArray<FKTableViewSectionModel*>*) sectionModels;
@end

NS_ASSUME_NONNULL_END
