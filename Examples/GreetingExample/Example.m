//
// Created by Simon Schmid
//
// contact@sschmid.com
//

#import "Example.h"
#import "GDDispatcher.h"
#import "Greeting.h"

@implementation Example

- (id)init {
    self = [super init];
    if (self) {

        GDDispatcher *dispatcher = [GDDispatcher sharedDispatcher];
        [dispatcher addObserver:self forObject:[Greeting class] withSelector:@selector(doSthLast:) priority:-5];
        [dispatcher addObserver:self forObject:[Greeting class] withSelector:@selector(doSthFirst:) priority:10];

        [dispatcher dispatchObject:[[Greeting alloc] initWithString:@"Hello"]];

    }

    return self;
}

- (void)doSthFirst:(Greeting *)greeting {
    NSLog(@"Got greeting first: %@", greeting.string);
}

- (void)doSthLast:(Greeting *)greeting {
    NSLog(@"Got greeting last: %@", greeting.string);
}

@end