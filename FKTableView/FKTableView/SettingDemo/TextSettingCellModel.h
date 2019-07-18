//
//  TextSettingCellModel.h
//  FKTableView
//
//  Created by CHAT on 2019/7/18.
//  Copyright © 2019 CHAT. All rights reserved.
//

#import "FKCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TextSettingCellModel : FKCellModel
@property (nonatomic, copy) NSString* txt;
- (instancetype)initWithText:(NSString*) txt;
@end

NS_ASSUME_NONNULL_END
