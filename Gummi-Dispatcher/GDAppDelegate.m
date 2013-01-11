//
// Created by Simon Schmid
//
// contact@sschmid.com
//


#import "GDAppDelegate.h"
#import "Example.h"


@implementation GDAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    Example *example = [[Example alloc] init];

    return YES;
}

@end
