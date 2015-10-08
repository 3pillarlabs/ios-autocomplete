//
//  JSONManager.h
//  AutoCompletion
//


#import <Foundation/Foundation.h>

@interface JSONManager : NSObject

+ (NSArray*) items;
+ (NSArray *)getItemsFromApiResponseDataObject:(NSData *)responseData;

@end
