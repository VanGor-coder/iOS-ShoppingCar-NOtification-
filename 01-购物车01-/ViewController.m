//
//  ViewController.m
//  01-购物车01-
//
//  Created by GaoFan on 2020/7/9.
//  Copyright © 2020 GaoFan. All rights reserved.
//

#import "ViewController.h"
#import "JFTableViewCell.h"
#import "JFModel.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *Sum;
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;

@property (nonatomic,strong) NSArray *arr;

@end
@implementation ViewController

-(NSArray *)arr
{
    if (_arr == nil) {
        _arr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"wineData.plist" ofType:nil]];
        NSMutableArray *arrTemp = [NSMutableArray array];
        for (NSDictionary *dict in _arr) {
            JFModel *model = [[JFModel alloc]init];
            model.imageName = dict[@"iamgeName"];
            model.name = dict[@"name"];
            model.price = dict[@"price"];
            model.count = dict[@"count"];
            [arrTemp addObject:model];
        }
        _arr = arrTemp;
    }
    return _arr;;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 80;
    
    //监听通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(plusButtonClick:) name:@"plusButtonClickNSNotification" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(minusButtonClick:) name:@"minusButtonClickNSNotification" object:nil];
}

//移除监听-控制器不再监听任何通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma -mark 通知监听的方法
-(void)plusButtonClick:(NSNotification *)note
{
    //通知的发布者
    JFTableViewCell *one = note.object;
    //计算总价
    int totalPrice = self.Sum.text.intValue + one.model.price.intValue;
    //设置总价
    self.Sum.text = [NSString stringWithFormat:@"%d",totalPrice];
    //控制购买按钮的状态
    self.buyBtn.enabled = YES;
    
}

-(void)minusButtonClick:(NSNotification *)note
{
    JFTableViewCell *one = note.object;
    int totalPrice = self.Sum.text.intValue - one.model.price.intValue;
    self.Sum.text = [NSString stringWithFormat:@"%d",totalPrice];
    //控制购买按钮的状态
    self.buyBtn.enabled = totalPrice>0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID= @"cell";
    JFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.model = self.arr[indexPath.row];
    return cell;
}

//清空购物车
- (IBAction)clearShopCar
{
    //总价清零
    self.Sum.text = @"0";

    //修改模型
    for (JFModel *model in self.arr) {
        model.count = @"0";
    }
    
    //刷新表格
    [self.tableView reloadData];
    
    //控制购买按钮的状态
    self.buyBtn.enabled = NO;
}

//结算
- (IBAction)CountPrice
{
    //打印用户购买的商品个数
    for (JFModel *model in self.arr) {
        if (model.count.intValue > 0) {
            NSLog(@"购买了%@件%@,共%d元",model.count,model.name,model.price.intValue* model.count.intValue);
        }
    }
    NSLog(@"合计:%d 元",self.Sum.text.intValue);
}
//在控制器监听button的点击事件 (缺点:依赖cell的层级关系)
//- (IBAction)ClickPlus:(UIButton *)btn
//{
//    JFTableViewCell *cell  = (JFTableViewCell *) btn.superview.superview;
//    cell.model.count  = [NSString stringWithFormat:@"%d",cell.model.count.intValue + 1];
//    self.Sum.text = @"234";
//    [self.tableView reloadData];
//}
//
//- (IBAction)ClickMinus:(UIButton *)btn
//{
//    JFTableViewCell *cell  = (JFTableViewCell *) btn.superview.superview;
//    cell.model.count  = [NSString stringWithFormat:@"%d",cell.model.count.intValue - 1];
//    [self.tableView reloadData];
//}


@end
