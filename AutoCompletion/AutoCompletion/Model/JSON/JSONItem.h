//
//  JSONItem.h
//  AutoCompletion
//


#import <Foundation/Foundation.h>

@interface JSONItem : NSObject

@property (nonatomic, retain) NSString * title;

- (instancetype)initWithDictionary:(NSDictionary*)dictionary;

@end
