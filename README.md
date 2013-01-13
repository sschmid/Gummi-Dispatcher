# Gummi Dispatcher
![Gummi Dispatcher Logo](http://sschmid.com/Libs/Gummi-Dispatcher/Gummi-Dispatcher-128.png)

## Description
Observe and dispatch any objects.

## Features
* Dispatch any object (no NSNotification like in NSNotificationCenter)
* Add observers with priority

## How to use Gummi Dispatcher
#### Get a dispatcher
```objective-c
// Create your own dispatcher
GDDispatcher *dispatcher = [[GDDispatcher alloc] init];

// or use the shared dispatcher
GDDispatcher *dispatcher = [GDDispatcher sharedDispatcher];
```

#### Add observers
```objective-c
[dispatcher addObserver:self forObject:[Greeting class]
           withSelector:@selector(doSthLast:) priority:-5];

[dispatcher addObserver:self forObject:[Greeting class]
           withSelector:@selector(doSthFirst:) priority:10];
```
#### Dispatch objects
```objective-c
[dispatcher dispatchObject:[[Greeting alloc] initWithString:@"Hello"]];

// Logs
// Got greeting first: Hello
// Got greeting last: Hello
```

```objective-c
- (void)doSthFirst:(Greeting *)greeting {
    NSLog(@"Got greeting first: %@", greeting.string);
}

- (void)doSthLast:(Greeting *)greeting {
    NSLog(@"Got greeting last: %@", greeting.string);
}
```

## Ideas / Roadmap
* Add method addObserverOnce:forObject:withSelector:priority:

## Install Gummi Dispatcher
You find the source files you need in Gummi-Dispatcher/Classes.

## CocoaPods
Install [CocoaPods] (http://cocoapods.org) and add the Gummi Dispatcher reference to your Podfile
```
platform :ios, '5.0'
  pod 'Gummi-Dispatcher'
end
```

#### Add this remote
```
$ pod repo add sschmid-cocoapods-specs https://github.com/sschmid/cocoapods-specs
```

#### Install Gummi Dispatcher
```
$ cd path/to/project
$ pod install
```
Open the created Xcode Workspace file.

## Projects that use Gummi Dispatcher
* [Gummi Commander] (https://github.com/sschmid/Gummi-Commander) Event Command Mapping System for Objective-C.
