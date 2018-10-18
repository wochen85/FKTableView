//
//  FKPersonCellModell.m
//  FKTableView
//
//  Created by CHAT on 2018/10/18.
//  Copyright © 2018 CHAT. All rights reserved.
//

#import "FKPersonCellModel.h"

@implementation FKPersonCellModel
- (RACSubject<NSString *> *)ageChangeSignal
{
    if (!_ageChangeSignal)
    {
        _ageChangeSignal = [RACSubject subject];
    }
    return _ageChangeSignal;
}

@end
