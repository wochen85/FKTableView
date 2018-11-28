//
//  UITableViewHeaderFooterView+FKExtension.m
//  Pods
//
//  Created by CHAT on 2018/11/28.
//

#import "UITableViewHeaderFooterView+FKExtension.h"
#import <objc/runtime.h>
#import "FKTableViewHeaderFooterModel.h"

@implementation UITableViewHeaderFooterView (FKExtension)

- (FKTableViewHeaderFooterModel *)headerFooterModel
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setHeaderFooterModel:(FKTableViewHeaderFooterModel *)headerFooterModel
{
    objc_setAssociatedObject(self, @selector(headerFooterModel), headerFooterModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self fk_bindModel:headerFooterModel];
}

+(instancetype) fk_headerFooterForTableView:(UITableView*) tableView headerFooterModel:(FKTableViewHeaderFooterModel*)headerFooterModel
{
    NSString* idf = headerFooterModel.nibName;
    UITableViewHeaderFooterView* headerFooterView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:idf];
    if (nil == headerFooterView)
    {
        UINib* nib = [UINib nibWithNibName:idf bundle:nil];
        [tableView registerNib:nib forHeaderFooterViewReuseIdentifier:idf];
        headerFooterView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:idf];
    }
    headerFooterView.headerFooterModel = headerFooterModel;
    return headerFooterView;
}

-(void) fk_bindModel:(FKTableViewHeaderFooterModel*) headerFooterModel;
{
    
}

@end