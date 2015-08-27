//
//  DetailViewTableViewCell.h
//  NetMonitor
//
//  Created by 柏晓强 on 15/8/26.
//  Copyright (c) 2015年 柏晓强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *website;
@property (weak, nonatomic) IBOutlet UILabel *interval;
@property (weak, nonatomic) IBOutlet UILabel *code;
@property (weak, nonatomic) IBOutlet UILabel *time;

@end
