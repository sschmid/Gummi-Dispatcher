//
// Created by Simon Schmid
//
// contact@sschmid.com
//

#import <Foundation/Foundation.h>

@class GDDispatcher;

@interface InterestingObject : NSObject
@property(nonatomic, strong) GDDispatcher *dispatcher;

- (void)addDelegate:(id)delegate priority:(int)priority;

- (void)start;
@end