//
//  NSFetchOperation.h
//  TextFieldSearch
//
//  Created by Flaviu Silaghi on 29/06/15.
//  Copyright (c) 2015 Flaviu Silaghi. All rights reserved.
//

#import "Operation.h"


typedef void (^JSONFetchCompletionBlock)(NSArray *items);

@interface FetchOperation : Operation

- (id)initWithCompletionBlock:(JSONFetchCompletionBlock)completionBlock incompleteString:(NSString*)string;


@end
