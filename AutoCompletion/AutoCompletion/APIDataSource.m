//
//  APIDataSource.m
//  AutoCompletion
//
//  Created by Flaviu Silaghi on 08/07/15.
//  Copyright (c) 2015 Flaviu Silaghi. All rights reserved.
//

#import "APIDataSource.h"
#import "GetJSONOperation.h"
#import "Constants.h"
#import "NSString+URLEncoding.h"

@interface RequestObject ()
@property (nonatomic, strong) NSString* incompleteString;
@property (nonatomic, strong) FetchCompletionBlock completionBlock;
@end

@implementation RequestObject
@end

@interface APIDataSource ()

@property(strong,nonatomic) NSOperationQueue *fetchQueue;
@property RequestObject *requestDataObject;
@end

@implementation APIDataSource

- (void)fetchSuggestionsForIncompleteString:(NSString*)incompleteString
                        withCompletionBlock:(FetchCompletionBlock)completion
{
    if (_fetchQueue.operationCount > 0) {
        [_fetchQueue cancelAllOperations];
    }
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(timeoutRequestWithRequestedObject:) object:self.requestDataObject];
    self.requestDataObject = [RequestObject new];
    [self.requestDataObject setIncompleteString:[incompleteString urlEncodeUsingEncoding:NSUTF8StringEncoding]];
    [self.requestDataObject setCompletionBlock:completion];
    //Postpone the search request
    [self performSelector:@selector(timeoutRequestWithRequestedObject:) withObject:self.requestDataObject afterDelay:0.3];
}

- (void)timeoutRequestWithRequestedObject:(RequestObject *)requestDataObject {
    NSString *urlString = [NSString stringWithFormat:@"https://www.googleapis.com/customsearch/v1?key=%@&q=%@&cx=%@",apiKey,requestDataObject.incompleteString, engineID];
    NSURL *downloadURL = [NSURL URLWithString:urlString ];
    GetJSONOperation *operation = [[GetJSONOperation alloc] initWithDownloadURL:downloadURL
                                                            withCompletionBlock:requestDataObject.completionBlock];
    [_fetchQueue addOperation:operation];
}
@end


