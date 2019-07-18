//
//  TextSettingCellModel.m
//  FKTableView
//
//  Created by CHAT on 2019/7/18.
//  Copyright © 2019 CHAT. All rights reserved.
//

#import "TextSettingCellModel.h"
#import <FKTableView.h>

@implementation TextSettingCellModel
- (instancetype)initWithText:(NSString*) txt
{
    self = [super init];
    if (self) {
        _txt = txt;
    }
    return self;
}
@end
