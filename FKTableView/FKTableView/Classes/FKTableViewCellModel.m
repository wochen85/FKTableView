//
//  FKTableViewRowModel.m
//  FKTableView
//
//  Created by CHAT on 2018/10/18.
//  Copyright © 2018 CHAT. All rights reserved.
//

#import "FKTableViewCellModel.h"

@interface FKTableViewCellModel()
@property (nonatomic, strong) RACSubject<FKTableViewCellModel*>* selectedSignal;
@end

@implementation FKTableViewCellModel
- (RACSubject<FKTableViewCellModel *> *)selectedSignal
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
