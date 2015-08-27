//
//  WebEntry.h
//  NetMonitor
//
//  Created by 柏晓强 on 15/8/27.
//  Copyright (c) 2015年 柏晓强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebEntry : NSObject
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *name_zh;
@property (nonatomic,strong) NSString *time;
@property (nonatomic,strong) NSString *status;
@property (nonatomic) int code;
@property (nonatomic) BOOL isDown;
@property (nonatomic) int interval_time;
@property (nonatomic) int down_last_week;
+(instancetype)webEntryWithData:(NSDictionary *)dict;
-(instancetype)initWithData:(NSDictionary *)dict;
@end
