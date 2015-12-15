//
//  DownloadOperation.m
//  AutoCompletion
//


#import "RequestOperation.h"

@interface RequestOperation()

@property (nonatomic) NSURL *url;
@property (nonatomic) NSURLConnection *connection;
@property (nonatomic) NSMutableData *data;
@property (nonatomic) NSURLResponse *response;
@property (nonatomic) BOOL terminated;
@property (nonatomic, copy) RequestCompletionBlock completion;

@end

@implementation RequestOperation

- (id) initWithUrl:(NSURL*)url completion:(RequestCompletionBlock)completion {
    self = [super init];
    
    if (self) {
        self.url = url;
        self.completion = completion;
    }
    
    return self;
}

#pragma mark - NSOperation

- (void)main {
    if (self.isCancelled) return;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    
    self.response = nil;
    self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
    
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    
    [self.connection scheduleInRunLoop:runLoop forMode:NSDefaultRunLoopMode];
    [self.connection start];
    
    while(!self.terminated && !self.isCancelled) {
        [runLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
}

- (BOOL)isFinished {
    return self.terminated;
}

- (void)cancel {
    [self reset];
    [super cancel];
}

#pragma mark - NSURLConnectionDelegate -

- (void) connection: (NSURLConnection *) connection didReceiveResponse: (NSURLResponse *) response {
    if ([self isCancelled]) {
        [self reset];
        return;
    }
    
    self.response = response;
    self.data = [NSMutableData new];
}

- (void) connection: (NSURLConnection *) connection didReceiveData: (NSData *) data {
    if ([self isCancelled]) {
        [self reset];
        return;
    }
    
    [self.data appendData: data];
}

- (void) connectionDidFinishLoading: (NSURLConnection *) connection {
    if ([self isCancelled]) {
        [self reset];
        return;
    }
    
    if (self.completion) {
        __weak typeof(self) weakSelf = self;
        
        self.completion(weakSelf.url, weakSelf.response, weakSelf.data, nil);
    
    }
    
    [self reset];
}

- (void) connection: (NSURLConnection *) connection didFailWithError: (NSError *) error {
    if ([self isCancelled]) {
        [self reset];
        return;
    }
    
    if (self.completion) {
        __weak typeof(self) weakSelf = self;
        
        self.completion(weakSelf.url, weakSelf.response, weakSelf.data, error);
        
    }
    
    [self reset];
}

#pragma mark - private methods -

- (void) reset {
    self.terminated = YES;
    
    [self.connection cancel];
    self.connection = nil;
    
    self.data = nil;
}

@end
