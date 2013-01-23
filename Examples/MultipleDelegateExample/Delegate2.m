//
// Created by Simon Schmid
//
// contact@sschmid.com
//

#import "Delegate2.h"
#import "Message.h"

@implementation Delegate2
- (void)logMessage:(Message *)message {
    NSLog(@"Delegate2: %@", message.content);
}
@end