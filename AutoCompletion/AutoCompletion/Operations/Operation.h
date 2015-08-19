//
//  Operation.h
//  operation
//
//  Created by Flaviu Silaghi on 24/06/15.
//  Copyright (c) 2015 Flaviu Silaghi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    Initialized,
    Pending,
    EvaluateConditions,
    Ready,
    Executing,
    Finishing,
    Finished,
    Canceled
} State;


@interface Operation : NSOperation

@property (nonatomic, copy) void (^completionWithError)(NSError*);
@property (nonatomic, copy) void (^completionWithSuccess)(NSError*);

- (void)completedWithError:(NSError*)error;
- (void)completedWithSuccess;


@end
