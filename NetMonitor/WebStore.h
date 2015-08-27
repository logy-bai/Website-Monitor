//
//  WebStore.h
//  NetMonitor
//
//  Created by 柏晓强 on 15/8/25.
//  Copyright (c) 2015年 柏晓强. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WebEntry;

@interface WebStore : NSObject
@property (nonatomic,readonly) NSArray *allWebEntry;

+ (instancetype)sharedStore;
- (void)addWebEntry:(WebEntry *)webEntry;
- (void)removeAllEntry;

@end
