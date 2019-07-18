//
//  SwitchSettingCell.m
//  FKTableView
//
//  Created by CHAT on 2019/7/18.
//  Copyright © 2019 CHAT. All rights reserved.
//

#import "SwitchSettingCell.h"
#import <Masonry.h>
#import <FKTableView.h>
#import "SwitchSettingCellModel.h"

@interface SwitchSettingCell()
@property (nonatomic, strong) UILabel* txtLabel;
@property (nonatomic, strong) UISwitch* switcher;
@end

@implementation SwitchSettingCell

- (UILabel *)txtLabel
{
    if (!_txtLabel)
    {
        _txtLabel = [UILabel new];
    }
    return _txtLabel;
}

- (UISwitch *)switcher
{
    if (!_switcher)
    {
        _switcher = [UISwitch new];
        [_switcher addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _switcher;
}

-(void) switchChanged:(UISwitch*) sender
{
    SwitchSettingCellModel* cellModel = (SwitchSettingCellModel*)self.fk_viewModel;
    [cellModel.switchChangeSignal sendNext:@(sender.isOn)];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self initSubViews];
    }
    return self;
}

- (void)fk_bindModel:(SwitchSettingCellModel*)model
{
    self.txtLabel.text = model.txt;
    self.switcher.on = model.switchOn;
}

-(void) initSubViews
{
    [self.contentView addSubview:self.txtLabel];
    [self.contentView addSubview:self.switcher];
    [self.txtLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
        make.right.mas_equalTo(self.switcher.mas_left);
    }];
    
    [self.switcher mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
    }];
}

@end
