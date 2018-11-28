//
//  MyTableViewHeaderFooterViewModel.h
//  FKTableView
//
//  Created by CHAT on 2018/11/28.
//  Copyright © 2018 CHAT. All rights reserved.
//

#import "FKTableViewHeaderFooterModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyTableViewHeaderFooterViewModel : FKTableViewHeaderFooterModel

- (instancetype)initWithLabelText:(NSString*) labelText buttonText:(NSString*) buttonText;
@property (nonatomic, copy) NSString* labelText;
@property (nonatomic, copy) NSString* buttonText;

@property (nonatomic, strong) RACSubject* buttonSignal;
@end

NS_ASSUME_NONNULL_END
