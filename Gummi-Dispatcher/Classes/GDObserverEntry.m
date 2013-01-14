//
// Created by Simon Schmid
//
// contact@sschmid.com
//

#import "GDObserverEntry.h"

@implementation GDObserverEntry

- (id)initWithObserver:(id)observer forObject:(Class)objectClass withSelector:(SEL)selector priority:(int)priority removeAfterExecution:(BOOL)remove {
    self = [super init];
    if (self) {

        if (![observer respondsToSelector:selector])
            @throw [NSException exceptionWithName:[NSString stringWithFormat:@"%@Exception", NSStringFromClass([self class])]
                                           reason:[NSString stringWithFormat:@"Observer '%@' does not respond to selector '%@'",
                                                                             NSStringFromClass([observer class]), NSStringFromSelector(selector)]
                                         userInfo:nil];

        self.observer = observer;
        self.objectClass = objectClass;
        self.selector = selector;
        self.priority = priority;
        self.remove = remove;
    }

    return self;
}

- (void)executeWithObject:(id)object {
    [self.observer performSelector:self.selector withObject:object];
}

@end
