//
//  JSONManager.m
//  AutoCompletion
//


#import "JSONManager.h"
#import "JSONItem.h"

@interface JSONManager ()

@property (nonatomic, strong) NSArray *items;

@end

@implementation JSONManager

- (instancetype)init
{
    if (self = [super init]) {
        NSError *error = nil;
        NSArray *jsonObject = [NSJSONSerialization JSONObjectWithData:[self jsonData] options:NSJSONReadingMutableContainers error:&error];
        NSAssert(jsonObject != nil, @"Unable to create JSON object due to error %@", error);
        
        NSMutableArray *items = [NSMutableArray array];
        for (NSDictionary *dictionary in jsonObject) {
            JSONItem *item = [[JSONItem alloc] initWithDictionary:dictionary];
            [items addObject:item];
        }
        
        _items = [NSArray arrayWithArray:items];
        
    }
    return self;
}

#pragma mark - Business Methods

+ (NSArray*) items
{
    return [JSONManager sharedInstance].items;
}

+ (NSArray *)getItemsFromApiResponseDataObject:(NSData *)responseData{
    NSError *error = nil;
    if (responseData == nil) {
        return [NSArray new];
    }
    NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseData options: NSJSONReadingMutableContainers error: &error];
    id dataItem = [JSON objectForKey:@"items"];
    NSMutableArray *responseItems = [NSMutableArray new];
    if ([dataItem isKindOfClass:[NSArray class]]) {
        NSArray *items = dataItem;
        for (id item in items) {
            if ([item isKindOfClass:[NSDictionary class]] && [[item objectForKey:@"kind"] isEqualToString:@"customsearch#result"]) {
                JSONItem *jsonItem = [JSONItem new];
                [jsonItem setTitle:[item objectForKey:@"title"]];
                [responseItems addObject:jsonItem];
            }
        }
    }
    
    return responseItems;
}

#pragma mark - Private methods

- (NSData *)jsonData {
    NSURL *jsonFileUrl = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"file.json"];
    NSData *data = [NSData dataWithContentsOfURL:jsonFileUrl];
    if (!data) {
        data = [NSData dataWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"file" withExtension:@"json"]];
        [data writeToURL:jsonFileUrl atomically:NO];
    }
    
    NSAssert(data != nil, @"Didn't find questions JSON file.");
    return data;
}

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.3PillarGlobal.Questionaire" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


#pragma mark - Singleton

+ (instancetype)sharedInstance {
    static JSONManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

@end
