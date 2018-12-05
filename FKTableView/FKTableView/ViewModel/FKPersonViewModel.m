//
//  FKPersonViewModel.m
//  FKTableView
//
//  Created by CHAT on 2018/10/18.
//  Copyright © 2018 CHAT. All rights reserved.
//

#import "FKPersonViewModel.h"
#import "FKPersonCellModel.h"
#import <FKTableView.h>
#import "MyTableViewHeaderFooterViewModel.h"

@interface FKPersonViewModel()
@property(nonatomic, copy) void (^handleSelected)(FKCellModel* x);
@end

@implementation FKPersonViewModel
- (RACSignal *)fresh
{
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
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
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
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
            NSMutableArray<FKCellModel*>* tmpRowModels = [NSMutableArray array];
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
                [tmpRowModels addObject:model];
            }
            
            MyTableViewHeaderFooterViewModel* headModel = [[MyTableViewHeaderFooterViewModel alloc] initWithLabelText:[NSString stringWithFormat:@"%@", @(j)] buttonText:[NSString stringWithFormat:@"section header %@", @(j)]];
            MyTableViewHeaderFooterViewModel* footModel = [[MyTableViewHeaderFooterViewModel alloc] initWithLabelText:[NSString stringWithFormat:@"%@", @(j)] buttonText:[NSString stringWithFormat:@"section footer %@", @(j)]];
            [headModel.buttonSignal subscribeNext:^(id  _Nullable x) {
                [self.showFullNameSignal sendNext:[NSString stringWithFormat:@"头部 %@ 被点击", @(j)]];
            }];
            [footModel.buttonSignal subscribeNext:^(id  _Nullable x) {
                [self.showFullNameSignal sendNext:[NSString stringWithFormat:@"尾部 %@ 被点击", @(j)]];
            }];
            FKSectionHeaderFooterConfig* headConfig = [[FKSectionHeaderFooterConfig alloc] initWithHeight:50 headFooterModel:headModel];
            FKSectionHeaderFooterConfig* footConfig = [[FKSectionHeaderFooterConfig alloc] initWithHeight:30 headFooterModel:footModel];
            FKSectionModel* sectionModel = [[FKSectionModel alloc] initWithRowModels:tmpRowModels headConfig:headConfig footConfig:footConfig];
            
            [_sectionModelArr addObject:sectionModel];
        }

        _commonSectionModelArr = [NSMutableArray array];
        for (int j=0; j<5; j++)
        {
            NSMutableArray<FKCellModel*>* tmpRowModels = [NSMutableArray array];
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
                [tmpRowModels addObject:model];
            }

            NSAttributedString* text = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"section header %@", @(j)]];
            FKSectionHeaderFooterCommonModel* headModel = [[FKSectionHeaderFooterCommonModel alloc] initWithText:text bgColor:[UIColor lightGrayColor] textAlignment:NSTextAlignmentCenter];
            text = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"section footer %@", @(j)]];
            FKSectionHeaderFooterCommonModel* footModel = [[FKSectionHeaderFooterCommonModel alloc] initWithText:text bgColor:[UIColor redColor] textAlignment:NSTextAlignmentRight];
            [headModel.clickSignal subscribeNext:^(id  _Nullable x) {
                [self.showFullNameSignal sendNext:[NSString stringWithFormat:@"头部 %@ 被点击", @(j)]];
            }];
            [footModel.clickSignal subscribeNext:^(id  _Nullable x) {
                [self.showFullNameSignal sendNext:[NSString stringWithFormat:@"尾部 %@ 被点击", @(j)]];
            }];
            FKSectionHeaderFooterConfig* headConfig = [[FKSectionHeaderFooterConfig alloc] initWithHeight:50 headFooterModel:headModel];
            FKSectionHeaderFooterConfig* footConfig = [[FKSectionHeaderFooterConfig alloc] initWithHeight:30 headFooterModel:footModel];
            FKSectionModel* sectionModel = [[FKSectionModel alloc] initWithRowModels:tmpRowModels headConfig:headConfig footConfig:footConfig];

            [_commonSectionModelArr addObject:sectionModel];
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

-(void (^)(FKCellModel* x)) handleSelected
{
    if (!_handleSelected)
    {
        @weakify(self);
        _handleSelected = ^(FKCellModel * _Nullable x) {
            @strongify(self);
            FKPersonCellModel* model = (FKPersonCellModel*)x;
            [self.showFullNameSignal sendNext:model.age];
        };
    }
    return _handleSelected;
}

@end
