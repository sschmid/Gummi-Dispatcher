//
// Created by Simon Schmid
//
// contact@sschmid.com
//


#import "GDObserverEntry.h"


@implementation GDObserverEntry
@synthesize observer = _observer;
@synthesize objectClass = _objectClass;
@synthesize selector = _selector;
@synthesize priority = _priority;

- (id)initWithObserver:(id)observer forObject:(Class)objectClass withSelector:(SEL)selector priority:(int)priority {
    self = [super init];
    if (self) {
        self.observer = observer;
        self.objectClass = objectClass;
        self.selector = selector;
        self.priority = priority;
    }

    return self;
}

- (void)executeWithObject:(id)object {
    [self.observer performSelector:self.selector withObject:object];
}

@end