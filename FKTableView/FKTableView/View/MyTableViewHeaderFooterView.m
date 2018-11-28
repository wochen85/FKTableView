//
//  MyTableViewHeaderFooterView.m
//  FKTableView
//
//  Created by CHAT on 2018/11/28.
//  Copyright © 2018 CHAT. All rights reserved.
//

#import "MyTableViewHeaderFooterView.h"
#import "UITableViewHeaderFooterView+FKExtension.h"
#import "MyTableViewHeaderFooterViewModel.h"

@interface MyTableViewHeaderFooterView()
@property (weak, nonatomic) IBOutlet UILabel *fklabel;
@property (weak, nonatomic) IBOutlet UIButton *fkButton;


@end

@implementation MyTableViewHeaderFooterView
- (void)fk_bindModel:(MyTableViewHeaderFooterViewModel *)headerFooterModel
{
    self.fklabel.text = headerFooterModel.labelText;
    [self.fkButton setTitle:headerFooterModel.buttonText forState:(UIControlStateNormal)];
    
    [[self.fkButton.rac_command.executionSignals takeUntil:self.rac_prepareForReuseSignal] subscribeNext:^(RACSignal<id> * _Nullable x) {
        [headerFooterModel.buttonSignal sendNext:x];
    }];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.fkButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal empty];
    }];
}
@end
