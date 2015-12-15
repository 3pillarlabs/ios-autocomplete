//
//  CoreDataDataSource.m
//  AutoCompletion
//


#import "CoreDataDataSource.h"
#import "CoreDataOperation.h"

@interface CoreDataDataSource ()
{
    CoreDataOperation *operation;
}

@end

@implementation CoreDataDataSource

- (void)fetchSuggestionsForIncompleteString:(NSString*)incompleteString
                        withCompletionBlock:(FetchCompletionBlock)completion
{
    if (!operation) {
        NSLog(@"init operation");
        operation = [[CoreDataOperation alloc] initWithCompletionBlock:^(NSArray *items) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(items,@"title");
            });
        }];
    }
    
    
    [operation fetchObjectsWithString:incompleteString];

}

@end
