//
//  MyTableViewHeaderFooterViewModel.m
//  FKTableView
//
//  Created by CHAT on 2018/11/28.
//  Copyright © 2018 CHAT. All rights reserved.
//

#import "MyTableViewHeaderFooterViewModel.h"

@implementation MyTableViewHeaderFooterViewModel
- (instancetype)initWithLabelText:(NSString*) labelText buttonText:(NSString*) buttonText
{
    self = [super init];
    if (self) {
        _labelText = labelText;
        _buttonText = buttonText;
    }
    return self;
}

- (RACSubject *)buttonSignal
{
    if (nil == _buttonSignal)
    {
        _buttonSignal = [RACSubject subject];
    }
    return _buttonSignal;
}
@end
