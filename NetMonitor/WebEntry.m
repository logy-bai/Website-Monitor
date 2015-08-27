//
//  WebEntry.m
//  NetMonitor
//
//  Created by 柏晓强 on 15/8/27.
//  Copyright (c) 2015年 柏晓强. All rights reserved.
//

#import "WebEntry.h"

@implementation WebEntry

+(instancetype)webEntryWithData:(NSDictionary *)dict{
    return [[self alloc] initWithData:dict];
}

-(instancetype)initWithData:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        self.name = dict[@"name"];
        self.name_zh = dict[@"name_zh"];
        self.time = dict[@"time"];
        self.status = dict[@"status"];
        self.code = [dict[@"code"] intValue];
        self.isDown = [dict[@"isDown"] boolValue];
        self.interval_time = [dict[@"interval_time"] intValue];
        self.down_last_week = [dict[@"down_last_week"] intValue];
    }
    return self;
}

@end
