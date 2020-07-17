//
//  JFTableViewCell.h
//  01-购物车01-
//
//  Created by GaoFan on 2020/7/9.
//  Copyright © 2020 GaoFan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JFModel;
NS_ASSUME_NONNULL_BEGIN

@interface JFTableViewCell : UITableViewCell
@property (nonatomic,strong) JFModel *model;
@end

NS_ASSUME_NONNULL_END
