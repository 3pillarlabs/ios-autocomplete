//
//  DownloadOperation.h
//  Site Inspect
//
//  Created by Gil Eluard on 04/06/15.
//  Copyright (c) 2015 Social Tables. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^RequestCompletionBlock)(NSURL *url, NSURLResponse *response, NSData *data, NSError *error);

@interface RequestOperation : NSOperation

- (id) initWithUrl:(NSURL*)url completion:(RequestCompletionBlock)completion;

@end
