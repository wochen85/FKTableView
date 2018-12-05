//
//  UITableViewHeaderFooterView+FKExtension.h
//  Pods
//
//  Created by CHAT on 2018/11/28.
//



NS_ASSUME_NONNULL_BEGIN

@class FKHeaderFooterModel;
@interface UITableViewHeaderFooterView (FKExtension)
+(instancetype) fk_headerFooterForTableView:(UITableView*) tableView headerFooterModel:(FKHeaderFooterModel*)headerFooterModel;
//-(void) fk_bindModel:(FKHeaderFooterModel*) headerFooterModel;
@property (nonatomic, strong, readonly) FKHeaderFooterModel* fk_headerFooterModel;
@end

NS_ASSUME_NONNULL_END
