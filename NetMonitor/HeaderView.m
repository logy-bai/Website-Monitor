//
//  HeaderView.m
//  NetMonitor
//
//  Created by 柏晓强 on 15/8/26.
//  Copyright (c) 2015年 柏晓强. All rights reserved.
//

#import "HeaderView.h"
#import "WebEntry.h"

@implementation HeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithWebEntry:(WebEntry *)webEntry{
    self = [super init];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:nil options:nil][0];
        self.website.text = webEntry.name_zh;
        self.count.text = [NSString stringWithFormat:@"%d",webEntry.down_last_week];
        if (webEntry.isDown) {
            self.status.image = [UIImage imageNamed:@"red.png"];
        }else{
            self.status.image = [UIImage imageNamed:@"green.png"];
        }
    }
    return self;
}
-(void)rotationIndicator:(CGFloat)angle{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    
    self.indicator.transform = CGAffineTransformRotate(self.indicator.transform, angle);
    
    [UIView commitAnimations];
    
}
-(void)changeCount{
    
}
@end
