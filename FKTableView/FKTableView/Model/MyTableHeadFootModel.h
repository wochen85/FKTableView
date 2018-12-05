//
//  MyTableHeadFootModel.h
//  FKTableView
//
//  Created by CHAT on 2018/12/5.
//  Copyright © 2018 CHAT. All rights reserved.
//

#import "FKHeaderFooterModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyTableHeadFootModel : FKHeaderFooterModel
@property (nonatomic, copy) NSString*  labelText;
@property (nonatomic) NSInteger segmentIndex;
@property (nonatomic, copy) NSString* buttonText;
@end

NS_ASSUME_NONNULL_END
