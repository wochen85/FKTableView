//
//  FKTableViewRowModel.h
//  FKTableView
//
//  Created by CHAT on 2018/10/18.
//  Copyright © 2018 CHAT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@class RACSubject;
@interface FKTableViewCellModel : NSObject
@property (nonatomic, strong, readonly) RACSubject<FKTableViewCellModel*>* selectedSignal;
@property (nonatomic, copy) NSString* nibName;
@end

NS_ASSUME_NONNULL_END
