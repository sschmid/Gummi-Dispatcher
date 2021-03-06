//
// Created by Simon Schmid
//
// contact@sschmid.com
//

#import "GDDispatcher.h"
#import "GDObserverEntry.h"

GDDispatcher *sDispatcher;

@interface GDDispatcher ()
@property(nonatomic, strong) NSMutableDictionary *observerEntries;
@end

@implementation GDDispatcher

+ (GDDispatcher *)sharedDispatcher {
    if (!sDispatcher)
        sDispatcher = [[self alloc] init];

    return sDispatcher;
}

- (id)init {
    self = [super init];
    if (self) {
        self.observerEntries = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)dispatchObject:(id)object {
    for (GDObserverEntry *entry in [[self getObserverEntriesForObject:[object class]] copy]) {
        if (entry.remove)
            [self removeObserver:entry.observer fromObject:entry.objectClass withSelector:entry.selector];

        [entry executeWithObject:object];
    }
}

- (void)addObserver:(id)observer forObject:(Class)objectClass withSelector:(SEL)selector {
    [self addObserver:observer forObject:objectClass withSelector:selector priority:0];
}

- (void)addObserver:(id)observer forObject:(Class)objectClass withSelector:(SEL)selector priority:(int)priority {
    [self addObserver:observer forObject:objectClass withSelector:selector priority:priority removeAfterExecution:NO];
}

- (void)addObserverOnce:(id)observer forObject:(Class)objectClass withSelector:(SEL)selector {
    [self addObserverOnce:observer forObject:objectClass withSelector:selector priority:0];
}

- (void)addObserverOnce:(id)observer forObject:(Class)objectClass withSelector:(SEL)selector priority:(int)priority {
    [self addObserver:observer forObject:objectClass withSelector:selector priority:priority removeAfterExecution:YES];
}

- (void)removeObserver:(id)observer fromObject:(Class)objectClass withSelector:(SEL)selector {
    NSMutableArray *observerEntriesForObject = [self getObserverEntriesForObject:objectClass];
    for (GDObserverEntry *entry in [observerEntriesForObject copy])
        if ([entry.observer isEqual:observer] && selector == entry.selector)
            [observerEntriesForObject removeObject:entry];
}

- (void)removeObserver:(id)observer fromObject:(Class)objectClass {
    NSMutableArray *observerEntriesForObject = [self getObserverEntriesForObject:objectClass];
    for (GDObserverEntry *entry in [observerEntriesForObject copy])
        if ([entry.observer isEqual:observer])
            [observerEntriesForObject removeObject:entry];
}

- (void)removeObserver:(id)observer {
    for (NSArray *observerEntriesForObject in [self.observerEntries allValues])
        for (GDObserverEntry *entry in [observerEntriesForObject copy])
            [self removeObserver:observer fromObject:entry.objectClass];
}

- (void)removeAllObservers {
    [self.observerEntries removeAllObjects];
}

- (BOOL)hasObserver:(id)observer forObject:(Class)objectClass withSelector:(SEL)selector {
    for (GDObserverEntry *entry in [self getObserverEntriesForObject:objectClass])
        if ([entry.observer isEqual:observer] && entry.selector == selector)
            return true;

    return NO;
}

- (BOOL)hasObserver:(id)observer forObject:(Class)objectClass {
    for (GDObserverEntry *entry in [self getObserverEntriesForObject:objectClass])
        if ([entry.observer isEqual:observer])
            return true;

    return NO;
}

- (BOOL)hasObserver:(id)observer {
    for (NSArray *observerEntriesForObject in [self.observerEntries allValues])
        for (GDObserverEntry *entry in observerEntriesForObject)
            if ([entry.observer isEqual:observer])
                return YES;

    return NO;
}


#pragma mark private

- (void)addObserver:(id)observer forObject:(Class)objectClass withSelector:(SEL)selector priority:(int)priority removeAfterExecution:(BOOL)remove {
    if ([self canAddObserver:observer forObject:objectClass withSelector:selector])
        [self insertObserverEntry:[[GDObserverEntry alloc] initWithObserver:observer forObject:objectClass withSelector:selector
                                                                   priority:priority removeAfterExecution:remove]
              intoObserverEntries:[self getObserverEntriesForObject:objectClass] withPriority:priority];

}

- (BOOL)canAddObserver:(id)observer forObject:(Class)objectClass withSelector:(SEL)selector {
    return ![self hasObserver:observer forObject:objectClass withSelector:selector];
}

- (void)insertObserverEntry:(GDObserverEntry *)observerEntry intoObserverEntries:(NSMutableArray *)observerEntriesForObject withPriority:(int)priority {
    GDObserverEntry *existingEntry;
    for (NSUInteger i = 0; i < observerEntriesForObject.count; i++) {
        existingEntry = observerEntriesForObject[i];
        if (existingEntry.priority < priority) {
            [observerEntriesForObject insertObject:observerEntry atIndex:i];

            return;
        }
    }
    [observerEntriesForObject addObject:observerEntry];
}

- (NSMutableArray *)getObserverEntriesForObject:(Class)objectClass {
    NSString *key = NSStringFromClass(objectClass);
    NSMutableArray *observerEntriesForName = self.observerEntries[key];
    if (!observerEntriesForName) {
        observerEntriesForName = [[NSMutableArray alloc] init];
        self.observerEntries[key] = observerEntriesForName;
    }

    return observerEntriesForName;
}

@end