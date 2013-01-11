//
// Created by Simon Schmid
//
// contact@sschmid.com
//


#import "Example.h"
#import "GDDispatcher.h"


@implementation Example

- (id)init {
    self = [super init];
    if (self) {

        GDDispatcher *dispatcher = [GDDispatcher sharedDispatcher];
        [dispatcher addObserver:self forObject:[NSObject class] withSelector:@selector(doSthLast:) priority:-5];
        [dispatcher addObserver:self forObject:[NSObject class] withSelector:@selector(doSthFirst:) priority:10];

        [dispatcher dispatchObject:[[NSObject alloc] init]];

    }

    return self;
}

- (void)doSthFirst:(NSObject *)object {
    NSLog(@"Hello");
}

- (void)doSthLast:(NSObject *)object {
    NSLog(@"World!");
}

@end