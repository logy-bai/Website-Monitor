//
//  HeaderView.h
//  NetMonitor
//
//  Created by 柏晓强 on 15/8/26.
//  Copyright (c) 2015年 柏晓强. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WebEntry;

@interface HeaderView : UIView
@property (weak, nonatomic) IBOutlet UILabel *website;
@property (weak, nonatomic) IBOutlet UIImageView *status;
@property (nonatomic) BOOL isExpanded;
@property (nonatomic) int index;
@property (weak, nonatomic) IBOutlet UIView *separate;
@property (weak, nonatomic) IBOutlet UILabel *count;
@property (weak, nonatomic) IBOutlet UIImageView *indicator;

-(instancetype)initWithWebEntry:(WebEntry *)webEntry;
-(void)rotationIndicator:(CGFloat)angle;
-(void)changeCount;
@end
