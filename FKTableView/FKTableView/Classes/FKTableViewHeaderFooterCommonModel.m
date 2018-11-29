//
//  FKTableViewHeaderFooterCommonModel.m
//  Pods
//
//  Created by chat on 2018/11/29.
//

#import "FKTableViewHeaderFooterCommonModel.h"

@implementation FKTableViewHeaderFooterCommonModel
- (instancetype)initWithText:(NSAttributedString*) text bgColor:(UIColor*) bgColor textAlignment:(NSTextAlignment) textAlignment
{
    self = [super init];
    if (self)
    {
        _text = text;
        _bgColor = bgColor;
        _textAlignment = textAlignment;
    }
    return self;
}

- (RACSubject *)clickSignal
{
    if (nil==_clickSignal)
    {
        _clickSignal = [RACSubject subject];
    }
    return _clickSignal;
}
@end
