//
//  GetJSONOperation.h
//  AutoCompletion
//


#import <Foundation/Foundation.h>
#import "AutoCompletionTextFieldDataSource.h"

@interface GetJSONOperation : NSOperation

- (instancetype)initWithDownloadURL:(NSURL*)url withCompletionBlock:(FetchCompletionBlock)completion;

@end
