//
//  BookSectionHeadFoot.m
//  FKTableView
//
//  Created by CHAT on 2019/7/11.
//  Copyright © 2019 CHAT. All rights reserved.
//

#import "BookSectionHeadFoot.h"
#import <Masonry.h>
#import "MyBookSectionHeadFootModel.h"
#import <FKTableView.h>

@interface BookSectionHeadFoot()
@property (nonatomic, strong) UILabel* label;
@end

@implementation BookSectionHeadFoot

- (UILabel *)label
{
    if (!_label)
    {
        _label = [UILabel new];
        _label.backgroundColor = [UIColor orangeColor];
    }
    return _label;
}

- (void)fk_bindModel:(MyBookSectionHeadFootModel*)model
{
    self.label.text = model.text;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self configSubviews];
    }
    return self;
}

- (void) configSubviews
{
    [self addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
