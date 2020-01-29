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
@property (nonatomic, strong) NSMutableArray *observers; // of id<MCObserverProtocol> objects
@end

@implementation MCObserver

- (NSMutableArray *)observers {
    if (!_observers) _observers = [[NSMutableArray alloc] initWithCapacity:0];
    return _observers;
}

- (void)addObserver:(id<MCObserverProtocol>)object {
    [self.observers addObject:object];
}

- (void)removeObserver:(id<MCObserverProtocol>)object {
    NSUInteger objectIndex = [self.observers indexOfObject:object];
    if (objectIndex) {
        [self.observers removeObjectAtIndex:objectIndex];
    }
}

- (void)notifyObserversDidChangeState:(MCSessionState)state peer:(MCPeerID *)peerID {
    for (id<MCObserverProtocol> observer in self.observers) {
        if ([observer respondsToSelector:@selector(didChangeState:peer:)]) {
            [observer didChangeState:state peer:peerID];
        }
    }
}

- (void)notifyObserversDidReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID {
    for (id<MCObserverProtocol> observer in self.observers) {
        if ([observer respondsToSelector:@selector(didReceiveData:fromPeer:)]) {
            [observer didReceiveData:data fromPeer:peerID];
        }
    }
}

- (void)notifyObserversDidStartReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID withProgress:(NSProgress *)progress {
    for (id<MCObserverProtocol> observer in self.observers) {
        if ([observer respondsToSelector:@selector(didStartReceivingResourceWithName:fromPeer:withProgress:)]) {
            [observer didStartReceivingResourceWithName:resourceName fromPeer:peerID withProgress:progress];
        }
    }
}

- (void)notifyObserversDidFinishReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID atURL:(NSURL *)localURL withError:(NSError *)error {
    for (id<MCObserverProtocol> observer in self.observers) {
        if ([observer respondsToSelector:@selector(didFinishReceivingResourceWithName:fromPeer:atURL:withError:)]) {
            [observer didFinishReceivingResourceWithName:resourceName fromPeer:peerID atURL:localURL withError:error];
        }
    }
}

- (void)notifyObserversDidReceiveStream:(NSInputStream *)stream withName:(NSString *)streamName fromPeer:(MCPeerID *)peerID {
    for (id<MCObserverProtocol> observer in self.observers) {
        if ([observer respondsToSelector:@selector(didReceiveStream:withName:fromPeer:)]) {
            [observer didReceiveStream:stream withName:streamName fromPeer:peerID];
        }
    }
}

@end
