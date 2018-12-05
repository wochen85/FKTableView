//
//  UITableView+FKExtension.h
//  FKTableView
//
//  Created by CHAT on 2018/10/18.
//  Copyright © 2018 CHAT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FKCellModel;
@class FKSectionModel;
@class FKHeaderFooterModel;
@interface UITableView (FKExtension)
-(void) fk_configRowModels:(NSArray<FKCellModel*>*) rowModels;
-(void) fk_configSectionModels:(NSArray<FKSectionModel*>*) sectionModels;
-(void) fk_configHeader:(nullable FKHeaderFooterModel*) headerModel;
-(void) fk_configFooter:(FKHeaderFooterModel*) footerModel;
@end

NS_ASSUME_NONNULL_END
