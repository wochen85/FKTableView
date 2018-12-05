//
//  FKTableViewHeaderFooterCommonModel.h
//  Pods
//
//  Created by chat on 2018/11/29.
//

#import "FKHeaderFooterModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FKHeaderFooterCommonModel : FKHeaderFooterModel
- (instancetype)initWithText:(NSAttributedString*) text bgColor:(UIColor*) bgColor textAlignment:(NSTextAlignment) textAlignment;

@property (nonatomic, strong) UIColor* bgColor;
@property (nonatomic, copy) NSAttributedString* text;
@property (nonatomic)        NSTextAlignment    textAlignment;
@property (nonatomic, strong) RACSubject* clickSignal;
@end

NS_ASSUME_NONNULL_END
