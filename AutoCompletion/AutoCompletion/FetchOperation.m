//
//  NSFetchOperation.m
//  TextFieldSearch
//
//  Created by Flaviu Silaghi on 29/06/15.
//  Copyright (c) 2015 Flaviu Silaghi. All rights reserved.
//

#import "FetchOperation.h"
#import "JSONManager.h"

@interface FetchOperation ()

@property(nonatomic,strong) NSString* incompleteString;
@property(nonatomic,copy) JSONFetchCompletionBlock resultCompletionBlock;
@property(nonatomic,strong) NSDictionary *info;

@end

@implementation FetchOperation

- (id)initWithCompletionBlock:(JSONFetchCompletionBlock)completionBlock incompleteString:(NSString*)string
{
    if (self = [super init]) {
        [self setResultCompletionBlock:completionBlock];
        [self setIncompleteString:string];
    }
    
    return self;
}

- (void)main
{
    if (self.isCancelled)
    {
        NSLog(@"cancel");
        return;
    }
    
    [self fetchDataWithString:_incompleteString];
}

- (void)fetchDataWithString:(NSString*)string
{
    NSArray *items = [JSONManager items];
    NSArray *result;
    
    if (string.length > 0)
    {
        NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"(SELF.title CONTAINS[cd] %@)",string];
        result = [items filteredArrayUsingPredicate:bPredicate];
    }
    else
    {
        result = [NSArray arrayWithArray:items];
    }
    
    if (_resultCompletionBlock) {
        _resultCompletionBlock(result);
    }
}


@end
