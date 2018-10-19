//
//  FKPersonViewModel.m
//  FKTableView
//
//  Created by CHAT on 2018/10/18.
//  Copyright © 2018 CHAT. All rights reserved.
//

#import "FKPersonViewModel.h"
#import "FKPersonCellModel.h"
#import "FKTableViewSectionModel.h"

@interface FKPersonViewModel()
@property(nonatomic, copy) void (^handleSelected)(FKTableViewCellModel* x);
@end

@implementation FKPersonViewModel
- (RACSignal *)fresh
{
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[self mutableArrayValueForKey:@"cellModelArr"] removeAllObjects];
            for (int i=0; i<20; i++)
            {
                FKPersonCellModel* model = [FKPersonCellModel new];
                model.personId = [NSString stringWithFormat:@"%@", @(i)];
                model.shortName = [NSString stringWithFormat:@"shortName %@", @(i)];
                model.fullName = [NSString stringWithFormat:@"fullName %@", @(i)];
                
                [model.selectedSignal subscribeNext:self.handleSelected];
                [model.ageChangeSignal subscribeNext:^(NSString * _Nullable x) {
                    NSLog(@"%@ : %@", model, x);
                }];
                [[self mutableArrayValueForKey:@"cellModelArr"] addObject:model];
            }
            [subscriber sendNext:nil];
        });
        return nil;
    }];
}

- (RACSignal *)loadMore
{
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSInteger count = self.cellModelArr.count;
            for (NSInteger i=count; i<count+20; i++)
            {
                FKPersonCellModel* model = [FKPersonCellModel new];
                model.personId = [NSString stringWithFormat:@"%@", @(i)];
                model.shortName = [NSString stringWithFormat:@"shortName %@", @(i)];
                model.fullName = [NSString stringWithFormat:@"fullName %@", @(i)];
                
                [model.selectedSignal subscribeNext:self.handleSelected];
                [model.ageChangeSignal subscribeNext:^(NSString * _Nullable x) {
                    NSLog(@"%@ : %@", model, x);
                }];
                [[self mutableArrayValueForKey:@"cellModelArr"] addObject:model];
            }
            [subscriber sendNext:nil];
        });
        return nil;
    }];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _cellModelArr = [NSMutableArray array];
        
        _sectionModelArr = [NSMutableArray array];
        for (int j=0; j<5; j++)
        {
            FKTableViewSectionModel* sectionModel = [FKTableViewSectionModel new];
            sectionModel.headConfig = [[FKTableSectionHeaderFooterConfig alloc] initWithHeight:20 bgColor:[UIColor lightGrayColor] title:@"header"];
            sectionModel.footConfig = [[FKTableSectionHeaderFooterConfig alloc] initWithHeight:20 bgColor:[UIColor darkGrayColor] title:@"footer"];
            for (int i=0; i<20; i++)
            {
                FKPersonCellModel* model = [FKPersonCellModel new];
                model.personId = [NSString stringWithFormat:@"%@ %@", @(j), @(i)];
                model.shortName = [NSString stringWithFormat:@"shortName %@ %@", @(j), @(i)];
                model.fullName = [NSString stringWithFormat:@"fullName %@ %@", @(j), @(i)];
                
                [model.selectedSignal subscribeNext:self.handleSelected];
                [model.ageChangeSignal subscribeNext:^(NSString * _Nullable x) {
                    NSLog(@"%@ : %@", model, x);
                }];
                [sectionModel.rowModels addObject:model];
            }
            [_sectionModelArr addObject:sectionModel];
        }
    }
    return self;
}

- (RACSubject<NSString *> *)showFullNameSignal
{
    if (!_showFullNameSignal)
    {
        _showFullNameSignal = [RACSubject subject];
    }
    return _showFullNameSignal;
}

-(void (^)(FKTableViewCellModel* x)) handleSelected
{
    if (!_handleSelected)
    {
        @weakify(self);
        _handleSelected = ^(FKTableViewCellModel * _Nullable x) {
            @strongify(self);
            FKPersonCellModel* model = (FKPersonCellModel*)x;
            [self.showFullNameSignal sendNext:model.age];
        };
    }
    return _handleSelected;
}

@end
