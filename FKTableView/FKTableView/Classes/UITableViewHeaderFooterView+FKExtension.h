//
//  UITableViewHeaderFooterView+FKExtension.h
//  Pods
//
//  Created by CHAT on 2018/11/28.
//



NS_ASSUME_NONNULL_BEGIN

@class FKViewModel;
@interface UITableViewHeaderFooterView (FKExtension)
+(instancetype) fk_headerFooterForTableView:(UITableView*) tableView headerFooterModel:(FKViewModel*)headerFooterModel;
@end

NS_ASSUME_NONNULL_END
