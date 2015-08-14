//
//  CoreDataOperation.m
//  AutoCompletion
//
//  Created by Flaviu Silaghi on 07/07/15.
//  Copyright (c) 2015 Flaviu Silaghi. All rights reserved.
//

#import "CoreDataOperation.h"
#import "CoreDataManager.h"
#import "Items.h"

@interface CoreDataOperation ()

@property(nonatomic,strong) NSAsynchronousFetchResult *result;
@property(nonatomic,copy) CoreDataFetchCompletionBlock completionBlock;

@end

@implementation CoreDataOperation

- (id)initWithCompletionBlock:(CoreDataFetchCompletionBlock)completionBlock
{
    if (self = [super init])
    {
        [self setCompletionBlock:completionBlock];
    }
    return self;
}

- (void)fetchObjectsWithString:(NSString*)string
{
    if (_result)
    {
        [_result cancel];
        NSLog(@"cancel");
    }
    
    __weak typeof(self) weakSelf = self;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Items"];
    
    if (string.length > 0)
    {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title CONTAINS[cd] %@",string];
        [fetchRequest setPredicate:predicate];
    }
    
    NSPersistentStoreAsynchronousFetchResultCompletionBlock resultBlock = ^(NSAsynchronousFetchResult *result)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (weakSelf.completionBlock) {
                weakSelf.completionBlock(result.finalResult);
            }
        });
    };
    
    
    NSAsynchronousFetchRequest *asyncFetch = [[NSAsynchronousFetchRequest alloc]
                                              initWithFetchRequest:fetchRequest
                                              completionBlock:resultBlock];
    NSManagedObjectContext *context = [CoreDataManager sharedInstance].managedObjectContext;
    [context performBlock:^{
        NSError *executeError = nil;
        weakSelf.result = (NSAsynchronousFetchResult *)[context executeRequest:asyncFetch error:&executeError];
        
    }];
}

#pragma mark - Asynchronous Progress Reporting

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(completedUnitCount))]) {
        NSNumber *newValue = [change objectForKey:@"new"];
//        NSLog(@"completed:%@",newValue);
    }
    else if ([keyPath isEqualToString:NSStringFromSelector(@selector(totalUnitCount))]) {
        NSNumber *newValue = [change objectForKey:@"new"];
        NSLog(@"total count:%@",newValue);
    }
}

- (void)dealloc {
    NSLog(@"dealloc");
}

@end
