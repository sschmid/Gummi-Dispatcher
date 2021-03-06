//
// Created by Simon Schmid
//
// contact@sschmid.com
//

#import "Kiwi.h"
#import "GDDispatcher.h"
#import "SomeObject.h"
#import "FlagObject.h"
#import "SomeObserver.h"
#import "HasObserverObserver.h"

SPEC_BEGIN(GDDispatcherSpec)

#pragma mark Helper blocks
        void (^hasNoObserver)(GDDispatcher *, id, id, SEL) = ^(GDDispatcher *dispatcher, id observer, id event, SEL sel) {
            BOOL has1 = [dispatcher hasObserver:observer forObject:[event class] withSelector:sel];
            BOOL has2 = [dispatcher hasObserver:observer forObject:[event class]];
            BOOL has3 = [dispatcher hasObserver:observer];

            [[theValue(has1) should] beNo];
            [[theValue(has2) should] beNo];
            [[theValue(has3) should] beNo];
        };

        void (^executeInOrder)(GDDispatcher *, id, SEL, int, SEL, int, SEL, int, SEL, int, SEL, int) =
                ^(GDDispatcher *dispatcher, id observer, SEL s1, int p1, SEL s2, int p2, SEL s3, int p3, SEL s4, int p4, SEL s5, int p5) {
                    id event = [[SomeObject alloc] init];
                    [dispatcher addObserver:observer forObject:[event class] withSelector:s1 priority:p1];
                    [dispatcher addObserver:observer forObject:[event class] withSelector:s2 priority:p2];
                    [dispatcher addObserver:observer forObject:[event class] withSelector:s3 priority:p3];
                    [dispatcher addObserver:observer forObject:[event class] withSelector:s4 priority:p4];
                    [dispatcher addObserver:observer forObject:[event class] withSelector:s5 priority:p5];
                    [dispatcher dispatchObject:event];
                };


        describe(@"GDDispatcher", ^{

            __block GDDispatcher *dispatcher = nil;
            beforeEach(^{
                dispatcher = [[GDDispatcher alloc] init];
            });

            it(@"instantiates an dispatcher", ^{
                [[dispatcher should] beKindOfClass:[GDDispatcher class]];
            });

            it(@"returns same dispatcher", ^{
                id o1 = [GDDispatcher sharedDispatcher];
                id o2 = [GDDispatcher sharedDispatcher];
                [[o1 should] equal:o2];
            });

            it(@"has no observers", ^{
                BOOL has = [dispatcher hasObserver:[[NSObject alloc] init]];
                [[theValue(has) should] beNo];
            });

            it(@"has no observers for object", ^{
                BOOL has = [dispatcher hasObserver:[[NSObject alloc] init] forObject:[SomeObject class]];
                [[theValue(has) should] beNo];
            });

            it(@"has no observers for object and selector", ^{
                BOOL has = [dispatcher hasObserver:[[NSObject alloc] init] forObject:[SomeObject class] withSelector:@selector(unknownSelector)];
                [[theValue(has) should] beNo];
            });

            context(@"when added an observer", ^{

                __block SomeObserver *observer;
                __block id object;
                __block SEL sel;
                beforeEach(^{
                    observer = [[SomeObserver alloc] init];
                    object = [[SomeObject alloc] init];
                    sel = @selector(test:);
                    [dispatcher addObserver:observer forObject:[object class] withSelector:sel priority:0];

                    // Add some unused observers
                    [dispatcher addObserver:[[SomeObserver alloc] init] forObject:[object class] withSelector:sel priority:0];
                    [dispatcher addObserver:[[SomeObserver alloc] init] forObject:[object class] withSelector:sel priority:0];
                    [dispatcher addObserver:[[SomeObserver alloc] init] forObject:[object class] withSelector:sel priority:0];
                    [dispatcher addObserver:[[SomeObserver alloc] init] forObject:[object class] withSelector:sel priority:0];
                });

                it(@"has observer", ^{
                    BOOL has = [dispatcher hasObserver:observer];
                    [[theValue(has) should] beYes];
                });

                it(@"has observer for object", ^{
                    BOOL has = [dispatcher hasObserver:observer forObject:[object class]];
                    [[theValue(has) should] beYes];
                });

                it(@"has observer for object and selector", ^{
                    BOOL has = [dispatcher hasObserver:observer forObject:[object class] withSelector:sel];
                    [[theValue(has) should] beYes];
                });

                it(@"raises exception, when observer does not respond to selector", ^{
                    [[theBlock(^{
                        [dispatcher addObserver:observer forObject:object withSelector:@selector(unknownSelector) priority:0];
                    }) should] raiseWithName:@"GDObserverEntryException"];
                });

                it(@"has no observer for wrong object", ^{
                    BOOL has = [dispatcher hasObserver:observer forObject:[FlagObject class]];
                    [[theValue(has) should] beNo];
                });

                it(@"removes observer", ^{
                    [dispatcher removeObserver:observer];
                    hasNoObserver(dispatcher, observer, object, sel);
                });

                it(@"removes observer object", ^{
                    [dispatcher removeObserver:observer fromObject:[object class]];
                    hasNoObserver(dispatcher, observer, object, sel);
                });

                it(@"removes observer for name and selector", ^{
                    [dispatcher removeObserver:observer fromObject:[object class] withSelector:sel];
                    hasNoObserver(dispatcher, observer, object, sel);
                });

                it(@"does not add duplicates", ^{
                    [dispatcher addObserver:observer forObject:[object class] withSelector:@selector(add1:) priority:0];
                    [dispatcher addObserver:observer forObject:[object class] withSelector:@selector(add1:) priority:1];
                    [dispatcher addObserver:observer forObject:[object class] withSelector:@selector(add1:) priority:2];
                    [dispatcher dispatchObject:[[SomeObject alloc] init]];
                    [[observer.result should] equal:@"1"];
                });

                it(@"removes the specified observer", ^{
                    [dispatcher addObserver:observer forObject:[object class] withSelector:@selector(add1:) priority:0];
                    [dispatcher addObserver:observer forObject:[object class] withSelector:@selector(add2:) priority:0];
                    [dispatcher removeObserver:observer fromObject:[object class] withSelector:@selector(add1:)];
                    BOOL has = [dispatcher hasObserver:observer forObject:[object class] withSelector:@selector(add1:)];
                    BOOL has2 = [dispatcher hasObserver:observer forObject:[object class] withSelector:@selector(add2:)];
                    [[theValue(has) should] beNo];
                    [[theValue(has2) should] beYes];
                });

                it(@"removes all observers", ^{
                    [dispatcher addObserver:observer forObject:[object class] withSelector:sel priority:0];
                    [dispatcher removeAllObservers];
                    hasNoObserver(dispatcher, observer, object, sel);
                });

            });

            it(@"executes multiple times", ^{
                SomeObject *object = [[SomeObject alloc] init];
                SomeObserver *observer = [[SomeObserver alloc] init];
                [dispatcher addObserver:observer forObject:[object class] withSelector:@selector(add1:)];
                [dispatcher dispatchObject:object];
                [dispatcher dispatchObject:object];
                [dispatcher dispatchObject:object];

                [[observer.result should] equal:@"111"];
            });

            context(@"when added an observer once", ^{

                it(@"removes observer when mapped once", ^{
                    SomeObject *object = [[SomeObject alloc] init];
                    SomeObserver *observer = [[SomeObserver alloc] init];
                    [dispatcher addObserverOnce:observer forObject:[object class] withSelector:@selector(add1:)];
                    [dispatcher dispatchObject:object];

                    BOOL has = [dispatcher hasObserver:observer forObject:[object class] withSelector:@selector(add1:)];

                    [[theValue(has) should] beNo];
                });

                it(@"removes observer when mapped once before performing selector", ^{
                    SomeObject *object = [[SomeObject alloc] init];
                    HasObserverObserver *observer = [[HasObserverObserver alloc] init];
                    observer.dispatcher = dispatcher;
                    [dispatcher addObserverOnce:observer forObject:[object class] withSelector:@selector(check:)];
                    [dispatcher dispatchObject:object];

                    [[theValue(observer.result) should] beNo];
                });

                it(@"executes only once and removes mapping", ^{
                    SomeObject *object = [[SomeObject alloc] init];
                    SomeObserver *observer = [[SomeObserver alloc] init];
                    [dispatcher addObserverOnce:observer forObject:[object class] withSelector:@selector(add1:)];

                    // Some unused observers
                    [dispatcher addObserverOnce:[[SomeObserver alloc] init] forObject:[object class] withSelector:@selector(add1:)];
                    [dispatcher addObserverOnce:[[SomeObserver alloc] init] forObject:[object class] withSelector:@selector(add1:)];
                    [dispatcher addObserverOnce:[[SomeObserver alloc] init] forObject:[object class] withSelector:@selector(add1:)];

                    [dispatcher dispatchObject:object];
                    [dispatcher dispatchObject:object];
                    [dispatcher dispatchObject:object];

                    [[observer.result should] equal:@"1"];
                });

            });

            it(@"executes in right order with priority 0", ^{
                SomeObserver *observer = [[SomeObserver alloc] init];
                executeInOrder(dispatcher, observer,
                        @selector(add1:), 0,
                        @selector(add2:), 0,
                        @selector(add3:), 0,
                        @selector(add4:), 0,
                        @selector(add5:), 0
                );

                [[observer.result should] equal:@"12345"];
            });

            it(@"executes in right order depending on priority", ^{
                SomeObserver *observer = [[SomeObserver alloc] init];
                executeInOrder(dispatcher, observer,
                        @selector(add1:), 2,
                        @selector(add2:), 4,
                        @selector(add3:), 6,
                        @selector(add4:), 8,
                        @selector(add5:), 10
                );

                [[observer.result should] equal:@"54321"];
            });

            it(@"executes in right order depending on priority", ^{
                SomeObserver *observer = [[SomeObserver alloc] init];
                executeInOrder(dispatcher, observer,
                        @selector(add1:), 10,
                        @selector(add2:), 8,
                        @selector(add3:), 6,
                        @selector(add4:), 4,
                        @selector(add5:), 2
                );

                [[observer.result should] equal:@"12345"];
            });

            it(@"executes in right order depending on priority", ^{
                SomeObserver *observer = [[SomeObserver alloc] init];
                executeInOrder(dispatcher, observer,
                        @selector(add1:), 10,
                        @selector(add2:), 6,
                        @selector(add3:), 2,
                        @selector(add4:), 4,
                        @selector(add5:), 8
                );

                [[observer.result should] equal:@"15243"];
            });

            it(@"executes in right order depending on priority", ^{
                SomeObserver *observer = [[SomeObserver alloc] init];
                executeInOrder(dispatcher, observer,
                        @selector(add1:), 10,
                        @selector(add2:), 6,
                        @selector(add3:), 6,
                        @selector(add4:), 7,
                        @selector(add5:), 7
                );

                [[observer.result should] equal:@"14523"];
            });

            it(@"executes in right order depending on negative priority", ^{
                SomeObserver *observer = [[SomeObserver alloc] init];
                executeInOrder(dispatcher, observer,
                        @selector(add1:), 0,
                        @selector(add2:), 1,
                        @selector(add3:), -1,
                        @selector(add4:), -3,
                        @selector(add5:), 5
                );

                [[observer.result should] equal:@"52134"];
            });

        });

        SPEC_END