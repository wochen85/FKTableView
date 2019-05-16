//
//  FKTableViewHeaderFooterCommonView.m
//  FKTableView
//
//  Created by CHAT on 2019/5/16.
//

#import "FKTableViewHeaderFooterCommonView.h"
#import "FKHeaderFooterCommon.h"
#import "UIView+FKExtension.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "FKHeaderFooterCommonModel.h"

@interface FKTableViewHeaderFooterCommonView()
@property (nonatomic, strong) FKHeaderFooterCommon* childView;
@end

@implementation FKTableViewHeaderFooterCommonView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self configSubViews];
    }
    return self;
}

- (FKHeaderFooterCommon *)childView
{
    if (!_childView)
    {
        _childView = [FKHeaderFooterCommon new];
    }
    return _childView;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.childView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
}

-(void) configSubViews
{
    [self addSubview:self.childView];
}

- (void)fk_bindModel:(FKHeaderFooterCommonModel*)headerFooterModel
{
    [self.childView fk_bindModel:headerFooterModel];
    [[self.childView.tapGes.rac_gestureSignal takeUntil:self.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        [headerFooterModel.clickSignal sendNext:x];
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
