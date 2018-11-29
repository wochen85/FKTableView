//
//  FKTableViewHeaderFooterCommonModel.h
//  Pods
//
//  Created by chat on 2018/11/29.
//

#import "FKTableViewHeaderFooterModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FKTableViewHeaderFooterCommonModel : FKTableViewHeaderFooterModel
- (instancetype)initWithText:(NSAttributedString*) text bgColor:(UIColor*) bgColor textAlignment:(NSTextAlignment) textAlignment;

@property (nonatomic, strong) UIColor* bgColor;
@property (nonatomic, copy) NSAttributedString* text;
@property (nonatomic)        NSTextAlignment    textAlignment;
@property (nonatomic, strong) RACSubject* clickSignal;
@end

NS_ASSUME_NONNULL_END
