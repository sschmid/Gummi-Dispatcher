//
// Created by Simon Schmid
//
// contact@sschmid.com
//

#import "MultipleDelegateExample.h"
#import "InterestingObject.h"
#import "Delegate1.h"
#import "Delegate2.h"
#import "Message.h"

@interface MultipleDelegateExample ()
@property(nonatomic, strong) InterestingObject *interestingObject;
@property(nonatomic, strong) Delegate1 *delegate1;
@property(nonatomic, strong) Delegate2 *delegate2;
@end

@implementation MultipleDelegateExample

- (id)init {
    self = [super init];
    if (self) {
        self.interestingObject = [[InterestingObject alloc] init];
        
        self.delegate1 = [[Delegate1 alloc] init];
        self.delegate2 = [[Delegate2 alloc] init];

        [self.interestingObject addDelegate:self priority:0];
        [self.interestingObject addDelegate:self.delegate1 priority:5];
        [self.interestingObject addDelegate:self.delegate2 priority:-2];

        [self.interestingObject start];
    }

    return self;
}

- (void)logMessage:(Message *)message {
    NSLog(@"Example: %@", message.content);
}

@end