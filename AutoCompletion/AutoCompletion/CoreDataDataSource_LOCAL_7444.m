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
    operation = [[CoreDataOperation alloc] initWithCompletionBlock:^(NSArray *items) {
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(items,@"title");
        });
    }];
    
    [operation fetchObjectsWithString:incompleteString];

}

@end
