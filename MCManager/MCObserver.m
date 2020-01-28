//
//  MCObserver.m
//  MCManager
//
//  Created by Maksym Ivanyk on 28.01.2020.
//  Copyright © 2020 Maksym Ivanyk. All rights reserved.
//

#import "MCObserver.h"
#import "MCObserverProtocol.h"

@interface MCObserver ()
@property (nonatomic, strong) NSMutableArray *observers; // of NSObject classes
@end

@implementation MCObserver

- (NSMutableArray *)observers {
    if (!_observers) _observers = [[NSMutableArray alloc] initWithCapacity:0];
    return _observers;
}

- (void)addObserver:(Class<MCObserverProtocol>)object {
    [self.observers addObject:[object class]];
}

- (void)removeObserver:(Class<MCObserverProtocol>)object {
    NSUInteger objectIndex = [self.observers indexOfObject:[object class]];
    if (objectIndex) {
        [self.observers removeObjectAtIndex:objectIndex];
    }
}

- (void)notifyObserversDidChangeState:(MCSessionState)state peer:(MCPeerID *)peerID {
    for (NSObject *observer in self.observers) {
        if ([observer respondsToSelector:@selector(didChangeState:peer:)]) {
            [(id<MCObserverProtocol>)observer didChangeState:state peer:peerID];
        }
    }
}

- (void)notifyObserversDidReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID {
    for (NSObject *observer in self.observers) {
        if ([observer respondsToSelector:@selector(didReceiveData:fromPeer:)]) {
            [(id<MCObserverProtocol>)observer didReceiveData:data fromPeer:peerID];
        }
    }
}

- (void)notifyObserversDidStartReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID withProgress:(NSProgress *)progress {
    for (NSObject *observer in self.observers) {
        if ([observer respondsToSelector:@selector(didStartReceivingResourceWithName:fromPeer:withProgress:)]) {
            [(id<MCObserverProtocol>)observer didStartReceivingResourceWithName:resourceName fromPeer:peerID withProgress:progress];
        }
    }
}

- (void)notifyObserversDidFinishReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID atURL:(NSURL *)localURL withError:(NSError *)error {
    for (NSObject *observer in self.observers) {
        if ([observer respondsToSelector:@selector(didFinishReceivingResourceWithName:fromPeer:atURL:withError:)]) {
            [(id<MCObserverProtocol>)observer didFinishReceivingResourceWithName:resourceName fromPeer:peerID atURL:localURL withError:error];
        }
    }
}

- (void)notifyObserversDidReceiveStream:(NSInputStream *)stream withName:(NSString *)streamName fromPeer:(MCPeerID *)peerID {
    for (NSObject *observer in self.observers) {
        if ([observer respondsToSelector:@selector(didReceiveStream:withName:fromPeer:)]) {
            [(id<MCObserverProtocol>)observer didReceiveStream:stream withName:streamName fromPeer:peerID];
        }
    }
}

@end
