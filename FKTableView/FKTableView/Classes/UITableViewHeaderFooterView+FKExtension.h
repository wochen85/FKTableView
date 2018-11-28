//
//  UITableViewHeaderFooterView+FKExtension.h
//  Pods
//
//  Created by CHAT on 2018/11/28.
//



NS_ASSUME_NONNULL_BEGIN

@class FKTableViewHeaderFooterModel;
@interface UITableViewHeaderFooterView (FKExtension)
+(instancetype) fk_headerFooterForTableView:(UITableView*) tableView headerFooterModel:(FKTableViewHeaderFooterModel*)headerFooterModel;
-(void) fk_bindModel:(FKTableViewHeaderFooterModel*) headerFooterModel;
@property (nonatomic, strong, readonly) FKTableViewHeaderFooterModel* headerFooterModel;
@end

NS_ASSUME_NONNULL_END
