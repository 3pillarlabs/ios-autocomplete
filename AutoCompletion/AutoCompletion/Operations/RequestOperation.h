//
//  DownloadOperation.h
//  AutoCompletion
//


#import <Foundation/Foundation.h>

typedef void (^RequestCompletionBlock)(NSURL *url, NSURLResponse *response, NSData *data, NSError *error);

@interface RequestOperation : NSOperation

- (id) initWithUrl:(NSURL*)url completion:(RequestCompletionBlock)completion;

@end
