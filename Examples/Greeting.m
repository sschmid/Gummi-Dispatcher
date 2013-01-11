//
// Created by Simon Schmid
//
// contact@sschmid.com
//


#import "Greeting.h"


@implementation Greeting
@synthesize string = _string;

- (id)initWithString:(NSString *)string {
    self = [super init];
    if (self) {
        self.string = string;
    }

    return self;
}

@end