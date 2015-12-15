//
//  JSONItemTests.m
//  AutoCompletion
//


#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "JSONItem.h"

@interface JSONItemTests : XCTestCase

@end

@implementation JSONItemTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testValidJSONItemInit {
    NSString *testTitle = @"testTitle";
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:testTitle forKey:@"title"];
    
    JSONItem *item = [[JSONItem alloc] initWithDictionary:dict];
    
    XCTAssertEqualObjects(item.title, testTitle, @"JSONItem init failed");
}

@end
