//
//  SwitchSettingCellModel.h
//  FKTableView
//
//  Created by CHAT on 2019/7/18.
//  Copyright © 2019 CHAT. All rights reserved.
//

#import "FKCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SwitchSettingCellModel : FKCellModel
@property (nonatomic, copy) NSString* txt;
@property (nonatomic) BOOL switchOn;
@property (nonatomic, strong) RACSubject<NSNumber*>* switchChangeSignal;
- (instancetype)initWithText:(NSString*) txt switchOn:(BOOL)switchOn;
@end

NS_ASSUME_NONNULL_END
