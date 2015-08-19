//
//  GetJSONOperation.h
//  AutoCompletion
//
//  Created by Flaviu Silaghi on 08/07/15.
//  Copyright (c) 2015 Flaviu Silaghi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AutoCompletionTextFieldDataSource.h"

@interface GetJSONOperation : NSOperation

- (instancetype)initWithDownloadURL:(NSURL*)url withCompletionBlock:(FetchCompletionBlock)completion;

@end
