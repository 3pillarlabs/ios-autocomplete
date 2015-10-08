//
//  CoreDataSourceTests.m
//  AutoCompletion
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "CoreDataDataSource.h"
#import "Items.h"

@interface CoreDataSourceTests : XCTestCase

@end

@implementation CoreDataSourceTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

#pragma mark - integration Testing

- (void)testCoreDataFetch {
    XCTestExpectation *openExpectation = [self expectationWithDescription:@"search open"];
    CoreDataDataSource *coreDataDataSource = [[CoreDataDataSource alloc] init];
    
    [coreDataDataSource fetchSuggestionsForIncompleteString:@"12345" withCompletionBlock:^(NSArray *items, NSString *textKey) {
        XCTAssertNotNil(items,@"Item is nil");
        XCTAssert([items count] == 1, @"Number of items returned is not what it should be");
        Items *item = [items objectAtIndex:0];
        XCTAssertTrue([item.title isEqualToString:@"Item 12345"], @"Return item is not correct");
        [openExpectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:1 handler:nil];
}

@end
