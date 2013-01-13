## Gummi Dispatcher
![Gummi Dispatcher Logo](http://sschmid.com/Libs/Gummi-Dispatcher/Gummi-Dispatcher-128.png)

Observe and dispatch any objects.

## Features
* Dispatch any object (no NSNotification like in NSNotificationCenter)
* Add observers with priority

## How to use Gummi Dispatcher

#### Add an observer an dispatch objects
```objective-c
// Create your own dispatcher
GDDispatcher *dispatcher = [[GDDispatcher alloc] init];

// or use the shared dispatcher
GDDispatcher *dispatcher = [GDDispatcher sharedDispatcher];

[dispatcher addObserver:self forObject:[Greeting class] withSelector:@selector(doSthLast:) priority:-5];
[dispatcher addObserver:self forObject:[Greeting class] withSelector:@selector(doSthFirst:) priority:10];

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

## Use Gummi Dispatcher in your project
You find the source files you need in Gummi-Dispatcher/Classes.

## CocoaPods
Create a Podfile and put it into your root folder of your project

#### Edit your Podfile
```
platform :ios, '5.0'
pod 'Gummi-Dispatcher'
```

#### Setup [CocoaPods], if not done already
```
$ sudo gem install cocoapods
$ pod setup
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

## Other projects using Gummi Dispatcher

* [Gummi Commander] (https://github.com/sschmid/Gummi-Commander) Event Command Mapping System for Objective-C

If you enjoy using Gummi Dispatcher in your projects let me know, and I'll mention your projects here.

[cocoapods]: http://cocoapods.org/
[Gummi Injection]: https://github.com/sschmid/Gummi-Injection/
