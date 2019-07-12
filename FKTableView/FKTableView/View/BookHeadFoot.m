//
//  BookHead.m
//  FKTableView
//
//  Created by CHAT on 2019/7/11.
//  Copyright © 2019 CHAT. All rights reserved.
//

#import "BookHeadFoot.h"
#import <FKTableView.h>
#import "MyBookHeadFootModel.h"
#import <Masonry.h>

@interface BookHeadFoot()
@property (nonatomic, strong) UILabel* label;
@end

@implementation BookHeadFoot

- (UILabel *)label
{
    if (!_label)
    {
        _label = [UILabel new];
        _label.backgroundColor = [UIColor lightGrayColor];
    }
    return _label;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (void)fk_bindModel:(MyBookHeadFootModel*)model
{
    self.label.text = model.text;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
