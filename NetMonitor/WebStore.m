//
//  WebStore.m
//  NetMonitor
//
//  Created by 柏晓强 on 15/8/25.
//  Copyright (c) 2015年 柏晓强. All rights reserved.
//

#import "WebStore.h"
#import "WebEntry.h"

@interface WebStore ()
@property(nonatomic) NSMutableArray *privateWebs;
@end

@implementation WebStore
+ (instancetype)sharedStore{
    static WebStore *sharedStore = nil;
    if (!sharedStore) {
        sharedStore = [[self alloc] initPrivate];
    }
    return sharedStore;
}

- (instancetype)init{
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"Use +[WebStore sharedStore]"
                                 userInfo:nil];
}

-(instancetype)initPrivate{
    self = [super init];
    if (!_privateWebs) {
        _privateWebs = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)addWebEntry:(WebEntry *)webEntry{
    [_privateWebs addObject:webEntry];
}

-(NSArray *)allWebEntry{
    return [_privateWebs copy];
}

-(void)removeAllEntry{
    [_privateWebs removeAllObjects];
}

@end
