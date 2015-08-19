//
//  JSONDataSource.m
//  AutoCompletion
//
//  Created by Flaviu Silaghi on 08/07/15.
//  Copyright (c) 2015 Flaviu Silaghi. All rights reserved.
//

#import "JSONDataSource.h"
#import "FetchOperation.h"

@interface JSONDataSource ()

@property(strong,nonatomic) NSOperationQueue *fetchQueue;

@end

@implementation JSONDataSource

- (instancetype)init
{
    if (self = [super init]) {
        _fetchQueue = [[NSOperationQueue alloc] init];
        _fetchQueue.name = [NSString stringWithFormat:@"Fetch operation :%d",arc4random()];
    }
    return self;
}

- (void)fetchSuggestionsForIncompleteString:(NSString*)incompleteString
                        withCompletionBlock:(FetchCompletionBlock)completion
{
    if (_fetchQueue.operationCount > 0) {
        [_fetchQueue cancelAllOperations];
    }
    
    FetchOperation *operation = [[FetchOperation alloc] initWithCompletionBlock:^(NSArray *items) {
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(items,@"title");
        });
        
    } incompleteString:incompleteString];
    
    [_fetchQueue addOperation:operation];
}

@end
