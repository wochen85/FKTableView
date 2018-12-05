//
//  FKTableViewRowModel.m
//  FKTableView
//
//  Created by CHAT on 2018/10/18.
//  Copyright © 2018 CHAT. All rights reserved.
//

#import "FKCellModel.h"

@interface FKCellModel()
@property (nonatomic, strong) RACSubject<FKCellModel*>* selectedSignal;
@end

@implementation FKCellModel
- (RACSubject<FKCellModel *> *)selectedSignal
{
    if (!_selectedSignal)
    {
        _selectedSignal = [RACSubject subject];
    }
    return _selectedSignal;
}

- (NSString *)nibName
{
    if (!_nibName)
    {
        NSString* selfString = NSStringFromClass([self class]);
        NSArray<NSString*>* arr = [selfString componentsSeparatedByString:@"Model"];
        if (arr.count)
        {
            _nibName = arr[0];
        }
        else
        {
            _nibName = @"";
        }
    }
    return _nibName;
}

@end
