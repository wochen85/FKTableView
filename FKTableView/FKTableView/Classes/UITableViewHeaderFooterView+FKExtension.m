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
#import "FKTableViewHeaderFooterCommonView.h"

@implementation UITableViewHeaderFooterView (FKExtension)

+(instancetype) fk_headerFooterForTableView:(UITableView*) tableView headerFooterModel:(FKViewModel*)headerFooterModel
{
    if ([headerFooterModel isKindOfClass:[FKHeaderFooterCommonModel class]])
    {
        static NSString* commonHeadFoot = @"commonHeadFoot";
        FKTableViewHeaderFooterCommonView* headerFooterView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:commonHeadFoot];
        if (nil == headerFooterView)
        {
            headerFooterView = [[FKTableViewHeaderFooterCommonView alloc] initWithReuseIdentifier:commonHeadFoot];
        }
        
        headerFooterView.fk_viewModel = headerFooterModel;
        return headerFooterView;
    }

    NSString* idf = headerFooterModel.nibOrClassName;
    UITableViewHeaderFooterView* headerFooterView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:idf];
    if (nil == headerFooterView)
    {
        NSString* nibPath = [[NSBundle mainBundle] pathForResource:idf ofType:@"nib"];
        if (nibPath)
        {
            UINib* nib = [UINib nibWithNibName:idf bundle:nil];
            [tableView registerNib:nib forHeaderFooterViewReuseIdentifier:idf];
        }
        else
        {
            [tableView registerClass:NSClassFromString(idf) forHeaderFooterViewReuseIdentifier:idf];
        }
        headerFooterView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:idf];
    }
    headerFooterView.fk_viewModel = headerFooterModel;
    return headerFooterView;
}

@end
