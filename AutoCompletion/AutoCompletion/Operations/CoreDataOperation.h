//
//  CoreDataOperation.h
//  AutoCompletion
//


#import "Operation.h"

typedef void (^CoreDataFetchCompletionBlock)(NSArray *items);

@interface CoreDataOperation : NSObject

- (id)initWithCompletionBlock:(CoreDataFetchCompletionBlock)completionBlock;
- (void)fetchObjectsWithString:(NSString*)string;

@end
