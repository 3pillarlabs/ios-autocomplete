//
//  CoreDataOperation.h
//  AutoCompletion
//
//  Created by Flaviu Silaghi on 07/07/15.
//  Copyright (c) 2015 Flaviu Silaghi. All rights reserved.
//

#import "Operation.h"

typedef void (^CoreDataFetchCompletionBlock)(NSArray *items);

@interface CoreDataOperation : NSObject

- (id)initWithCompletionBlock:(CoreDataFetchCompletionBlock)completionBlock;
- (void)fetchObjectsWithString:(NSString*)string;

@end
