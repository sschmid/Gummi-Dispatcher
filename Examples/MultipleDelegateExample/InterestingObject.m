//
// Created by Simon Schmid
//
// contact@sschmid.com
//

#import "InterestingObject.h"
#import "GDDispatcher.h"
#import "Message.h"

@implementation InterestingObject

- (id)init {
    self = [super init];
    if (self) {
        self.dispatcher = [[GDDispatcher alloc] init];
    }

    return self;
}

- (void)addDelegate:(id)delegate priority:(int)priority {
    [self.dispatcher addObserver:delegate forObject:[Message class] withSelector:@selector(logMessage:) priority:priority];
}

- (void)start {
    Message *message = [[Message alloc] init];
    message.content = @"Message dispatched";
    [self.dispatcher dispatchObject:message];
}

@end