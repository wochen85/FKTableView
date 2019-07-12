//
//  BookCellModel.m
//  FKTableView
//
//  Created by CHAT on 2019/7/11.
//  Copyright © 2019 CHAT. All rights reserved.
//

#import "BookCellModel.h"

@implementation BookCellModel
- (instancetype)initWithName:(NSString*)name author:(NSString*)author
{
    self = [super init];
    if (self) {
        _name = name;
        _author = author;
    }
    return self;
}

- (RACSubject *)clickedSignal
{
    if (!_clickedSignal)
    {
        _clickedSignal = [RACSubject subject];
    }
    return _clickedSignal;
}

@end
