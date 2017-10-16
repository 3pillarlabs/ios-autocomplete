//
//  CoreDataOperationTests.m
//  AutoCompletion
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "CoreDataOperation.h"

@interface CoreDataOperationTests : XCTestCase

@end

@implementation CoreDataOperationTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testValidCoreDataOperationInitialization {
    CoreDataOperation *operation = [[CoreDataOperation alloc] initWithCompletionBlock:nil];
    XCTAssertNotNil(operation, @"CoreDataOperation is nil");
    
}

#pragma mark - integration Testing

- (void)testValidDataIsReturnedForValidSearchString {
    XCTestExpectation *fetchExpectation = [self expectationWithDescription:@"fetch operation"];
    CoreDataOperation *operation = [[CoreDataOperation alloc] initWithCompletionBlock:^(NSArray *items) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [fetchExpectation fulfill];
            XCTAssertNotNil(items,@"Fetched itemsArray is nil");
            XCTAssert([items count] > 0, @"No results returned");
        });
    }];
    [operation fetchObjectsWithString:@"1"];
    [self waitForExpectationsWithTimeout:1 handler:nil];
}

- (void)testNoDataIsReturnedForInvalidSearchString {
    XCTestExpectation *fetchExpectation = [self expectationWithDescription:@"fetch operation"];
    CoreDataOperation *operation = [[CoreDataOperation alloc] initWithCompletionBlock:^(NSArray *items) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [fetchExpectation fulfill];
            XCTAssertNotNil(items,@"Fetched itemsArray is nil");
            XCTAssert([items count] == 0, @"results returned for invalid search text");
        });
    }];
    [operation fetchObjectsWithString:@"-11"];
    [self waitForExpectationsWithTimeout:1 handler:nil];
}

@end
