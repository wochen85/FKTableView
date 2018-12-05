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

#pragma mark - 存取器
- (FKCellModel *)fk_cellModel
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setFk_cellModel:(FKCellModel *)cellModel
{
    objc_setAssociatedObject(self, @selector(fk_cellModel), cellModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self fk_bindModel:cellModel];
}

+(instancetype) fk_cellForTableView:(UITableView*) tableView cellModel:(FKCellModel*)cellModel
{
    NSString* idf = cellModel.nibName;
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:idf];
    if (!cell)
    {
        [tableView registerNib:[UINib nibWithNibName:cellModel.nibName bundle:nil] forCellReuseIdentifier:idf];
        cell = [tableView dequeueReusableCellWithIdentifier:idf];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.fk_cellModel = cellModel;
    return cell;
}

//-(void) fk_bindModel:(FKCellModel*) cellModel
//{
//    
//}

@end
