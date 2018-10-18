//
//  FKPersonCellModell.h
//  FKTableView
//
//  Created by CHAT on 2018/10/18.
//  Copyright © 2018 CHAT. All rights reserved.
//

#import "FKTableViewCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FKPersonCellModel : FKTableViewCellModel
@property(nonatomic, copy) NSString* personId;
@property(nonatomic, copy) NSString* shortName;
@property(nonatomic, copy) NSString* fullName;
@property(nonatomic, copy) NSString* age;

@property(nonatomic, strong) RACSubject<NSString*>* ageChangeSignal;
@end

NS_ASSUME_NONNULL_END
