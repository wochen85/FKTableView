//
//  UITableViewCell+FKExtension.h
//  FKTableView
//
//  Created by CHAT on 2018/10/18.
//  Copyright © 2018 CHAT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FKCellModel;
@interface UITableViewCell (FKExtension)
+(instancetype) fk_cellForTableView:(UITableView*) tableView cellModel:(FKCellModel*)cellModel;
//-(void) fk_bindModel:(FKCellModel*) cellModel;
@property (nonatomic, strong, readonly) FKCellModel* fk_cellModel;
@end

NS_ASSUME_NONNULL_END
