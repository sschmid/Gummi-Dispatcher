## Gummi Dispatcher
![Gummi Dispatcher Logo](http://sschmid.com/Libs/Gummi-Dispatcher/Gummi-Dispatcher-128.png)

Observe and dispatch any objects.

## How to use Gummi Dispatcher

#### Add an observer an dispatch objects

```objective-c
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

#### Install Gummi
```
$ cd path/to/project
$ pod install
```

## Other projects using Gummi Dispatcher

* [Gummi Commander] (https://github.com/sschmid/Gummi-Commander) Event Command Mapping System for Objective-C

[cocoapods]: http://cocoapods.org/
[Gummi Injection]: https://github.com/sschmid/Gummi-Injection/
