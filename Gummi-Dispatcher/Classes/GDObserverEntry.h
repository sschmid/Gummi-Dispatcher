//
// Created by Simon Schmid
//
// contact@sschmid.com
//

#import <Foundation/Foundation.h>

@interface GDObserverEntry : NSObject
@property(nonatomic, strong) id observer;
@property(nonatomic, strong) Class objectClass;
@property(nonatomic) SEL selector;
@property(nonatomic) int priority;
@property(nonatomic) BOOL remove;

- (id)initWithObserver:(id)observer forObject:(Class)objectClass withSelector:(SEL)selector priority:(int)priority removeAfterExecution:(BOOL)remove;
- (void)executeWithObject:(id)object;

@end