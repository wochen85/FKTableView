//
//  SwitchSettingCellModel.m
//  FKTableView
//
//  Created by CHAT on 2019/7/18.
//  Copyright © 2019 CHAT. All rights reserved.
//

#import "SwitchSettingCellModel.h"

@implementation SwitchSettingCellModel
- (instancetype)initWithText:(NSString*) txt switchOn:(BOOL)switchOn
{
    self = [super init];
    if (self) {
        _txt = txt;
        _switchOn = switchOn;
    }
    return self;
}

- (RACSubject<NSNumber*>*)switchChangeSignal
{
    if (!_switchChangeSignal)
    {
        _switchChangeSignal = [RACSubject subject];
    }
    return _switchChangeSignal;
}
@end
