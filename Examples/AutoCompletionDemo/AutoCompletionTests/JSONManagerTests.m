//
//  JSONManagerTests.m
//  AutoCompletion
//


#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "JSONManager.h"
#import "RequestOperation.h"

@interface JSONManagerTests : XCTestCase

@end

@implementation JSONManagerTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testValidJSONManagerItems {
    XCTAssertNotNil([JSONManager items],@"JSON Manager array of items is nil");
}

#pragma mark - integration Testing

- (void)testValidJSONManagerItemsFromAPIResponse {
    XCTestExpectation *getItemsFromAPIResponseExpectation = [self expectationWithDescription:@"get Items from API response operation"];
    
    NSURL *testURL = [[NSURL alloc] initWithString:@"https://www.googleapis.com/customsearch/v1?key=AIzaSyBk8Mnz5EHHFKYxgnUD7gLkipn1j4YyozI&q=i&cx=000448205074692022280:b8zxhjeziqa"];
    
    RequestOperation *downloadOperation = [[RequestOperation alloc] initWithUrl:testURL completion:^(NSURL *url, NSURLResponse *response, NSData *data, NSError *error) {
        [getItemsFromAPIResponseExpectation fulfill];
        NSArray *items = [JSONManager getItemsFromApiResponseDataObject:data];
        XCTAssertNotNil(items,@"JSON Manager items from API response is nil");
    }];
    
    [[NSOperationQueue mainQueue] addOperation:downloadOperation];
    [self waitForExpectationsWithTimeout:1 handler:nil];
}

@end
