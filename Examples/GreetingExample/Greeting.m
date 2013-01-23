//
// Created by Simon Schmid
//
// contact@sschmid.com
//

#import "Greeting.h"

@implementation Greeting

- (id)initWithString:(NSString *)string {
    self = [super init];
    if (self) {
        self.string = string;
    }

    return self;
}

@end