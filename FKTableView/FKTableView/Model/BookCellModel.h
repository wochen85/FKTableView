//
//  BookCellModel.h
//  FKTableView
//
//  Created by CHAT on 2019/7/11.
//  Copyright © 2019 CHAT. All rights reserved.
//

#import "FKCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@class RACSubject;
@interface BookCellModel : FKCellModel
@property (nonatomic, copy) NSString* name;
@property (nonatomic, strong) NSString* author;
@property (nonatomic, strong) RACSubject* clickedSignal;
- (instancetype)initWithName:(NSString*)name author:(NSString*)author;
@end

NS_ASSUME_NONNULL_END
