//
// Created by Simon Schmid
//
// contact@sschmid.com
//


#import "SomeObject.h"
#import "FlagObject.h"

@implementation SomeObject
@synthesize object = _object;
@synthesize string = _string;

- (id)init {
    self = [super init];
    if (self) {
        self.string = [[NSString alloc] init];
    }

    return self;
}

@end