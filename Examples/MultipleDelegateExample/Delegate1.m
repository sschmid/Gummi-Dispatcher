//
// Created by Simon Schmid
//
// contact@sschmid.com
//

#import "Delegate1.h"
#import "Message.h"

@implementation Delegate1
- (void)logMessage:(Message *)message {
    NSLog(@"Delegate1: %@", message.content);
}
@end