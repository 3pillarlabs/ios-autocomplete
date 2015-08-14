//
//  CoreDataDataSource.m
//  AutoCompletion
//
//  Created by Flaviu Silaghi on 08/07/15.
//  Copyright (c) 2015 Flaviu Silaghi. All rights reserved.
//

#import "CoreDataDataSource.h"
#import "CoreDataOperation.h"

@interface CoreDataDataSource ()
{
    CoreDataOperation *operation;
}

@end

@implementation CoreDataDataSource

- (void)fetchSuggestionsForIncompleteString:(NSString*)incompleteString
                        withCompletionBlock:(FetchCompletionBlock)completion
{
<<<<<<< HEAD
    operation = [[CoreDataOperation alloc] initWithCompletionBlock:^(NSArray *items) {
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(items,@"title");
        });
    }];
=======
    if (!operation) {
        NSLog(@"init operation");
        operation = [[CoreDataOperation alloc] initWithCompletionBlock:^(NSArray *items) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(items);
            });
        }];
    }
    
>>>>>>> 5abc9b3174885962793c59c4e8825b921d30cfd2
    
    [operation fetchObjectsWithString:incompleteString];

}

@end
