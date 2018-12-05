//
//  FKPersonViewModel.h
//  FKTableView
//
//  Created by CHAT on 2018/10/18.
//  Copyright © 2018 CHAT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@class FKPersonCellModel;
@class FKSectionModel;
@interface FKPersonViewModel : NSObject
@property(nonatomic, strong) NSMutableArray<FKPersonCellModel*>* cellModelArr;
@property(nonatomic, strong) NSMutableArray<FKSectionModel*>* sectionModelArr;
@property(nonatomic, strong) NSMutableArray<FKSectionModel*>* commonSectionModelArr;
@property(nonatomic, strong) RACSubject<NSString*>* showFullNameSignal;

-(RACSignal*) fresh;
-(RACSignal*) loadMore;
@end

NS_ASSUME_NONNULL_END
