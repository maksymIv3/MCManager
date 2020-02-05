# MCManager

<p align="center">
<a href="https://cocoapods.org/pods/MCManager"><img alt="Version" src="https://img.shields.io/cocoapods/v/Randomizer.svg?style=flat"></a> 
<a href="https://github.com/Carthage/Carthage"><img alt="Version" src="https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat"></a>
<a href="https://github.com/maksymIv3/Randomizer/blob/master/LICENSE"><img alt="Liscence" src="https://img.shields.io/cocoapods/l/IgyToast.svg?style=flat"></a> 
<a href="https://developer.apple.com/"><img alt="Platform" src="https://img.shields.io/badge/platform-iOS-green.svg"/></a> 

## Installation

### CocoaPods

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate Alamofire into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'MCManager', '~> 0.0.8'
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks. To integrate Alamofire into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "maksymIv3/MCManager" ~> 0.0.8
```

## Usage

### Basic usage
import module:
```objective-c
#import <MCManager/MCManager.h>
```
add self as observer:

```objective-c
[[MCManager shared] addObserver:self];
```

setup peer and session with display name:
```objective-c
[[MCManager shared] setupPeerAndSessionWithDisplayName:[UIDevice currentDevice].name]];
```

to advertise self:
```objective-c
[[MCManager shared] advertiseSelf:YES];
```

setup browser:
```objective-c
[[MCManager shared] setupMCBrowser];
[[MCManager shared] setDelegate:self];
[self presentViewController:[[MCManager shared] browser] animated:YES completion:nil];
```

browser view controller delegate methods:
```objective-c
- (void)browserViewControllerDidFinish:(nonnull MCBrowserViewController *)browserViewController;
- (void)browserViewControllerWasCancelled:(nonnull MCBrowserViewController *)browserViewController;
```

diconnect: 
```objective-c
[[MCManager shared].session diconnect];
```

send data:
```objective-c
NSError *error;
MCManager *mcManager = [MCManager shared];
[mcManager.session sendData:data
                    toPeers:mcManager.session.connectedPeers
                   withMode:MCSessionSendDataReliable
                      error:&error];
```

to add self as observer we need to implement MCObserverProtocol:
```objective-c
#import <MCManager/MCObserverProtocol.h>

-(void)didChangeState:(MCSessionState)state peer:(MCPeerID *)peerID;
-(void)didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID;
-(void)didStartReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID withProgress:(NSProgress *)progress;
-(void)didFinishReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID atURL:(NSURL *)localURL withError:(NSError *)error;
-(void)didReceiveStream:(NSInputStream *)stream withName:(NSString *)streamName fromPeer:(MCPeerID *)peerID;
```
