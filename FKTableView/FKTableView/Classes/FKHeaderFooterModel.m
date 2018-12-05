//
//  FKTableViewHeaderFooterModel.m
//  Pods
//
//  Created by CHAT on 2018/11/28.
//

#import "FKHeaderFooterModel.h"

@interface FKHeaderFooterModel()
@end

@implementation FKHeaderFooterModel

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
