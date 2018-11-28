//
//  FKTableViewHeaderFooterModel.m
//  Pods
//
//  Created by CHAT on 2018/11/28.
//

#import "FKTableViewHeaderFooterModel.h"

@interface FKTableViewHeaderFooterModel()
@end

@implementation FKTableViewHeaderFooterModel

- (NSString *)nibName
{
    if (!_nibName)
    {
        NSString* selfString = NSStringFromClass([self class]);
        NSArray<NSString*>* arr = [selfString componentsSeparatedByString:@"Model"];
        if (arr.count)
        {
            _nibName = arr[0];
        }
        else
        {
            _nibName = @"";
        }
    }
    return _nibName;
}
@end
