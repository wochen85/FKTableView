//
//  FKPersonCell.m
//  FKTableView
//
//  Created by CHAT on 2018/10/18.
//  Copyright © 2018 CHAT. All rights reserved.
//

#import "FKPersonCell.h"
#import "FKPersonCellModel.h"
#import <FKTableView.h>

@interface FKPersonCell()
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *shortNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *ageTF;

@end

@implementation FKPersonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)fk_bindModel:(FKPersonCellModel *)cellModel
{
    self.idLabel.text = cellModel.personId;
    self.shortNameLabel.text = cellModel.shortName;
    self.ageTF.text = cellModel.age;
    [[self.ageTF.rac_textSignal takeUntil:self.rac_prepareForReuseSignal] subscribeNext:^(NSString * _Nullable x) {
        cellModel.age = x;
        [cellModel.ageChangeSignal sendNext:x];
    }];
}

@end
