//
//  MyTableViewHeaderFooterViewModel.h
//  FKTableView
//
//  Created by CHAT on 2018/11/28.
//  Copyright © 2018 CHAT. All rights reserved.
//

#import <FKTableCollectionExtensionBase/FKTableCollectionExtensionBase.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyTableViewHeaderFooterViewModel : FKViewModel

- (instancetype)initWithLabelText:(NSString*) labelText buttonText:(NSString*) buttonText;
@property (nonatomic, copy) NSString* labelText;
@property (nonatomic, copy) NSString* buttonText;

@property (nonatomic, strong) RACSubject* buttonSignal;
@end

NS_ASSUME_NONNULL_END
