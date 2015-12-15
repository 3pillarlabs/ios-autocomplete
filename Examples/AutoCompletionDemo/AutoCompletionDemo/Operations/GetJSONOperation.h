//
//  GetJSONOperation.h
//  AutoCompletion
//


#import <Foundation/Foundation.h>
#import <AutoCompletion/AutoCompletion.h>

@interface GetJSONOperation : NSOperation

- (instancetype)initWithDownloadURL:(NSURL*)url withCompletionBlock:(FetchCompletionBlock)completion;

@end
