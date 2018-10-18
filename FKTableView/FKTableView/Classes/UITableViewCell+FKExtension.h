//
//  UITableViewCell+FKExtension.h
//  FKTableView
//
//  Created by CHAT on 2018/10/18.
//  Copyright © 2018 CHAT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FKTableViewCellModel;
@interface UITableViewCell (FKExtension)
+(instancetype) fk_cellForTableView:(UITableView*) tableView cellModel:(FKTableViewCellModel*)cellModel;
-(void) fk_bindModel:(FKTableViewCellModel*) cellModel;
@property (nonatomic, strong, readonly) FKTableViewCellModel* cellModel;
@end

NS_ASSUME_NONNULL_END
