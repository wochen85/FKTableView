//
//  TextSettingCell.m
//  FKTableView
//
//  Created by CHAT on 2019/7/18.
//  Copyright © 2019 CHAT. All rights reserved.
//

#import "TextSettingCell.h"
#import <Masonry.h>
#import <FKTableView.h>
#import "TextSettingCellModel.h"

@interface TextSettingCell()
@property (nonatomic, strong) UILabel* txtLabel;
@end

@implementation TextSettingCell
- (UILabel *)txtLabel
{
    if (!_txtLabel)
    {
        _txtLabel = [UILabel new];
    }
    return _txtLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self initSubViews];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

- (void)fk_bindModel:(TextSettingCellModel*)model
{
    self.txtLabel.text = model.txt;
}

-(void) initSubViews
{
    [self.contentView addSubview:self.txtLabel];
    [self.txtLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
        make.right.mas_equalTo(-10);
    }];
}

@end
