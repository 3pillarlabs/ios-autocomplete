//
//  FetchOperationTests.m
//  AutoCompletion
//
//  Created by Norbert Agoston on 15/07/15.
//  Copyright (c) 2015 Flaviu Silaghi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "FetchOperation.h"

@interface FetchOperation (Test)

@property(nonatomic,strong) NSString* incompleteString;
@property(nonatomic,copy) JSONFetchCompletionBlock resultCompletionBlock;

@end

@interface FetchOperationTests : XCTestCase

@end

@implementation FetchOperationTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testValidFetchOperationInit {
    NSString *testString = @"1";
    FetchOperation *operation = [[FetchOperation alloc] initWithCompletionBlock:^(NSArray *items) {
        dispatch_async(dispatch_get_main_queue(), ^{
        });
        
    } incompleteString:testString];
    XCTAssertEqualObjects(operation.incompleteString, testString,@"Fetch Operation IncompleteString not initialized correctly");
    XCTAssertNotNil(operation.resultCompletionBlock,@"Fetch Operation CompletionBlock is nil");
}

#pragma mark - integration Testing

- (void)testValidFetchResultsForValidSearchString {
    XCTestExpectation *fetchExpectation = [self expectationWithDescription:@"fetch operation"];
    
    NSString *searchText = @"1";
    
    NSOperationQueue *fetchQueue = [[NSOperationQueue alloc] init];
    fetchQueue.name = [NSString stringWithFormat:@"Fetch operation :%d",arc4random()];
    
    if (fetchQueue.operationCount > 0) {
        [fetchQueue cancelAllOperations];
    }
    
    FetchOperation *operation = [[FetchOperation alloc] initWithCompletionBlock:^(NSArray *items) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [fetchExpectation fulfill];
            XCTAssertNotNil(items,@"Fetched itemsArray is nil");
            XCTAssert([items count] > 0, @"No results returned");
        });
        
    } incompleteString:searchText];
    [fetchQueue addOperation:operation];
    [self waitForExpectationsWithTimeout:1 handler:nil];
}

- (void)testNoFetchResultsForInvalidSearchString {
    XCTestExpectation *fetchExpectation = [self expectationWithDescription:@"fetch operation"];
    
    NSString *searchText = @"asd";
    
    NSOperationQueue *fetchQueue = [[NSOperationQueue alloc] init];
    fetchQueue.name = [NSString stringWithFormat:@"Fetch operation :%d",arc4random()];
    
    if (fetchQueue.operationCount > 0) {
        [fetchQueue cancelAllOperations];
    }
    
    FetchOperation *operation = [[FetchOperation alloc] initWithCompletionBlock:^(NSArray *items) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [fetchExpectation fulfill];
            XCTAssertNotNil(items,@"Fetched itemsArray is nil");
            XCTAssert([items count] == 0, @"results returned for invalid search text");
        });
        
    } incompleteString:searchText];
    [fetchQueue addOperation:operation];
    [self waitForExpectationsWithTimeout:1 handler:nil];
}

@end
