//
// Created by Simon Schmid
//
// contact@sschmid.com
//

#import <Foundation/Foundation.h>

@interface Greeting : NSObject
@property(nonatomic, copy) NSString *string;

- (id)initWithString:(NSString *)string;

@end