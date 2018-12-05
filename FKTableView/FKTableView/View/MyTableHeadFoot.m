//
//  MyTableHeadFoot.m
//  FKTableView
//
//  Created by CHAT on 2018/12/5.
//  Copyright © 2018 CHAT. All rights reserved.
//

#import "MyTableHeadFoot.h"
#import <FKTableView.h>
#import "MyTableHeadFootModel.h"

@interface MyTableHeadFoot()
@property (weak, nonatomic) IBOutlet UILabel *myLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *mySegment;
@property (weak, nonatomic) IBOutlet UIButton *myBtn;

@end

@implementation MyTableHeadFoot

- (void)fk_bindModel:(MyTableHeadFootModel*)model
{
    self.myLabel.text = model.labelText;
    self.mySegment.selectedSegmentIndex = model.segmentIndex;
    [self.myBtn setTitle:model.buttonText forState:(UIControlStateNormal)];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
