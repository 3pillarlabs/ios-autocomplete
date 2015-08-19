//
//  Operation.m
//  operation
//
//  Created by Flaviu Silaghi on 24/06/15.
//  Copyright (c) 2015 Flaviu Silaghi. All rights reserved.
//

#import "Operation.h"

@interface Operation ()

@property(nonatomic,assign) State state;

@end

@implementation Operation

- (id)init {
    if (self = [super init]) {
        _state = Initialized;
    }
    return self;
}

#pragma mark - Key Value Dependecy

+ (NSSet*)keyPathsForValuesAffectingIsReady
{
    NSLog(@"is ready");
    return [NSSet setWithObjects:@"state", nil];
}

+ (NSSet*)keyPathsForValuesAffectingIsExecuting
{
    NSLog(@"is executing");
    return [NSSet setWithObjects:@"state", nil];
}

+ (NSSet*)keyPathsForValuesAffectingIsFinished
{
    NSLog(@"is finished");
    return [NSSet setWithObjects:@"state", nil];
}

+ (NSSet*)keyPathsForValuesAffectingIsCancelled
{
    NSLog(@"is cancelled");
    return [NSSet setWithObjects:@"state", nil];
}

#pragma mark - Completion

- (void)completedWithError:(NSError*)error
{
    NSLog(@"operation:%@ completed with error:%@",self.name,error);
}

- (void)completedWithSuccess
{
    NSLog(@"operation completed:%@",self.name);
}

#pragma mark - State Management

- (void)willEnqueue
{
    _state = Pending;
}

- (BOOL)ready
{
    NSLog(@"ready");
    return super.ready;
}

- (BOOL)isExecuting
{
    NSLog(@"executing");
    return super.executing;
}



@end
