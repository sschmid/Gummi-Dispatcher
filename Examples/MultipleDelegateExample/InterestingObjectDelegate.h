//
// Created by Simon Schmid
//
// contact@sschmid.com
//

@class Message;

@protocol InterestingObjectDelegate <NSObject>
- (void)logMessage:(Message *)message;
@end