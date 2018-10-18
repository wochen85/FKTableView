//
//  UITableViewCell+FKExtension.m
//  FKTableView
//
//  Created by CHAT on 2018/10/18.
//  Copyright © 2018 CHAT. All rights reserved.
//

#import "UITableViewCell+FKExtension.h"
#import "FKTableViewCellModel.h"
#import <objc/runtime.h>

@implementation UITableViewCell (FKExtension)

#pragma mark - 存取器
- (FKTableViewCellModel *)cellModel
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setCellModel:(FKTableViewCellModel *)cellModel
{
    objc_setAssociatedObject(self, @selector(cellModel), cellModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self fk_bindModel:cellModel];
}

+(instancetype) fk_cellForTableView:(UITableView*) tableView cellModel:(FKTableViewCellModel*)cellModel
{
    NSString* idf = NSStringFromClass([self class]);
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:idf];
    if (!cell)
    {
        [tableView registerNib:[UINib nibWithNibName:cellModel.nibName bundle:nil] forCellReuseIdentifier:idf];
        cell = [tableView dequeueReusableCellWithIdentifier:idf];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.cellModel = cellModel;
    return cell;
}

-(void) fk_bindModel:(FKTableViewCellModel*) cellModel
{
    
}

@end
