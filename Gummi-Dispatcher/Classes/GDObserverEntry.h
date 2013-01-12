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

- (id)initWithObserver:(id)observer forObject:(Class)objectClass withSelector:(SEL)selector priority:(int)priority;
- (void)executeWithObject:(id)object;

@end