//
//  BookCell.m
//  FKTableView
//
//  Created by CHAT on 2019/7/11.
//  Copyright © 2019 CHAT. All rights reserved.
//

#import "BookCell.h"
#import <Masonry.h>
#import <FKTableView.h>
#import "BookCellModel.h"

@interface BookCell()
@property (nonatomic, strong) UILabel* nameLabel;
@property (nonatomic, strong) UILabel* authorLabel;
@property (nonatomic, strong) UIButton* button;
@end

@implementation BookCell
- (UILabel *)nameLabel
{
    if (!_nameLabel)
    {
        _nameLabel = [UILabel new];
    }
    return _nameLabel;
}

- (UILabel *)authorLabel
{
    if (!_authorLabel)
    {
        _authorLabel = [UILabel new];
    }
    return _authorLabel;
}

- (UIButton *)button
{
    if (!_button)
    {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setTitle:@"点我" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(clicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

-(void) clicked
{
    BookCellModel* cellModel = (BookCellModel*)self.fk_viewModel;
    [cellModel.clickedSignal sendNext:nil];
}

- (void)fk_bindModel:(BookCellModel*)model
{
    self.nameLabel.text = model.name;
    self.authorLabel.text = model.author;
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

-(void) initSubViews
{
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.authorLabel];
    [self.contentView addSubview:self.button];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(5);
        make.height.mas_equalTo(50);
        make.bottom.mas_equalTo(-5);
        make.width.mas_equalTo(100);
    }];
    
    [self.authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_right).offset(5);
        make.centerY.equalTo(self.nameLabel);
    }];
    
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.centerY.equalTo(self.nameLabel);
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
