//
//  JFTableViewCell.m
//  01-购物车01-
//
//  Created by GaoFan on 2020/7/9.
//  Copyright © 2020 GaoFan. All rights reserved.
//

#import "JFTableViewCell.h"
#import "JFModel.h"
@interface JFTableViewCell ()
@property (weak, nonatomic) IBOutlet UIButton *plusBtn;
@property (weak, nonatomic) IBOutlet UIButton *minusBtn;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@end
@implementation JFTableViewCell

-(UIButton *)setCircleBtn:(UIButton *)btn
{
    btn.layer.cornerRadius = self.plusBtn.frame.size.height *0.5;
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = [UIColor orangeColor].CGColor;
    return btn;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setCircleBtn:self.plusBtn];
    [self setCircleBtn:self.minusBtn];
}

- (void)setModel:(JFModel *)model
{
    _model = model;
    self.iconImageView.image = [UIImage imageNamed:model.imageName];
    self.titleLabel.text = model.name;
    self.priceLabel.text = model.price;
    self.countLabel.text = model.count;
    //根据模型的count属性决定减号按钮是否能够点击
    self.minusBtn.enabled = model.count.intValue > 0;
}

- (IBAction)Add
{
    self.model.count = [NSString stringWithFormat:@"%d",self.model.count.intValue +1];
    self.countLabel.text = self.model.count;
    self.minusBtn.enabled = YES;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"plusButtonClickNSNotification" object:self];
}

- (IBAction)Minus
{
        self.model.count = [NSString stringWithFormat:@"%d",self.model.count.intValue -1];
        self.countLabel.text = self.model.count;
    if (self.model.count.intValue == 0) {
        self.minusBtn.enabled = NO;
    }
     [[NSNotificationCenter defaultCenter]postNotificationName:@"minusButtonClickNSNotification" object:self];
}

@end
