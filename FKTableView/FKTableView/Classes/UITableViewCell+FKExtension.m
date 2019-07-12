//
//  UITableViewCell+FKExtension.m
//  FKTableView
//
//  Created by CHAT on 2018/10/18.
//  Copyright © 2018 CHAT. All rights reserved.
//

#import "UITableViewCell+FKExtension.h"
#import "FKCellModel.h"
#import <objc/runtime.h>
#import "UIView+FKExtension.h"

@implementation UITableViewCell (FKExtension)

+(instancetype) fk_cellForTableView:(UITableView*) tableView cellModel:(FKCellModel*)cellModel
{
    NSString* idf = cellModel.nibOrClassName;
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:idf];
    if (!cell)
    {
        NSString* nibPath = [[NSBundle mainBundle] pathForResource:idf ofType:@"nib"];
        if (nibPath)
        {
            [tableView registerNib:[UINib nibWithNibName:cellModel.nibOrClassName bundle:nil] forCellReuseIdentifier:idf];
        }
        else
        {
            [tableView registerClass:NSClassFromString(idf) forCellReuseIdentifier:idf];
        }
        cell = [tableView dequeueReusableCellWithIdentifier:idf];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.fk_viewModel = cellModel;
    return cell;
}

@end
