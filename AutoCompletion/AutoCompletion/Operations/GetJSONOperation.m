//
//  GetJSONOperation.m
//  AutoCompletion
//
//  Created by Flaviu Silaghi on 08/07/15.
//  Copyright (c) 2015 Flaviu Silaghi. All rights reserved.
//

#import "GetJSONOperation.h"
#import "RequestOperation.h"
#import "JSONManager.h"

@implementation GetJSONOperation

- (instancetype)initWithDownloadURL:(NSURL*)url withCompletionBlock:(FetchCompletionBlock)completion
{
    if (self = [super init]) {
        RequestOperation *downloadOperation = [[RequestOperation alloc] initWithUrl:url completion:^(NSURL *url, NSURLResponse *response, NSData *data, NSError *error) {
            NSArray *items = [JSONManager getItemsFromApiResponseDataObject:data];
            completion(items,@"title");
        }];

        [[NSOperationQueue mainQueue] addOperation:downloadOperation];
        
    }
    return self;
}

@end
