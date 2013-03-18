//
// Created by Simon Schmid
//
// contact@sschmid.com
//

#import <Foundation/Foundation.h>

@class GDDispatcher;
@class SomeObject;

@interface HasObserverObserver : NSObject
@property(nonatomic, strong) GDDispatcher *dispatcher;
@property(nonatomic) BOOL result;

- (void)check:(SomeObject *)object;

@end