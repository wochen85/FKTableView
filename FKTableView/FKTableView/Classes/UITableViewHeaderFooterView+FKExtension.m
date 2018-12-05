//
//  UITableViewHeaderFooterView+FKExtension.m
//  Pods
//
//  Created by CHAT on 2018/11/28.
//

#import "UITableViewHeaderFooterView+FKExtension.h"
#import <objc/runtime.h>
#import "FKTableView.h"
#import "FKHeaderFooterCommon.h"

@implementation UITableViewHeaderFooterView (FKExtension)

- (FKHeaderFooterModel *)fk_headerFooterModel
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setFk_headerFooterModel:(FKHeaderFooterModel *)headerFooterModel
{
    objc_setAssociatedObject(self, @selector(fk_headerFooterModel), headerFooterModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self fk_bindModel:headerFooterModel];
}

+(instancetype) fk_headerFooterForTableView:(UITableView*) tableView headerFooterModel:(FKHeaderFooterModel*)headerFooterModel
{
    if ([headerFooterModel isKindOfClass:[FKHeaderFooterCommonModel class]])
    {
        static NSString* commonHeadFoot = @"commonHeadFoot";
        FKHeaderFooterCommon* headerFooterView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:commonHeadFoot];
        if (nil == headerFooterView)
        {
            headerFooterView = [[FKHeaderFooterCommon alloc] initWithReuseIdentifier:commonHeadFoot];
        }
        headerFooterView.fk_headerFooterModel = headerFooterModel;
        return headerFooterView;
    }

    NSString* idf = headerFooterModel.nibName;
    UITableViewHeaderFooterView* headerFooterView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:idf];
    if (nil == headerFooterView)
    {
        UINib* nib = [UINib nibWithNibName:idf bundle:nil];
        [tableView registerNib:nib forHeaderFooterViewReuseIdentifier:idf];
        headerFooterView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:idf];
    }
    headerFooterView.fk_headerFooterModel = headerFooterModel;
    return headerFooterView;
}

//-(void) fk_bindModel:(FKHeaderFooterModel*) headerFooterModel;
//{
//    
//}

@end
