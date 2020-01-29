//
//  MCObserver.h
//  MCManager
//
//  Created by Maksym Ivanyk on 28.01.2020.
//  Copyright © 2020 Maksym Ivanyk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCObserverProtocol.h"

@interface MCObserver : NSObject
- (void)addObserver:(id<MCObserverProtocol>)object;
- (void)removeObserver:(id<MCObserverProtocol>)object;
- (void)notifyObserversDidChangeState:(MCSessionState)state peer:(MCPeerID *)peerID;
- (void)notifyObserversDidReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID;
- (void)notifyObserversDidStartReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID withProgress:(NSProgress *)progress;
- (void)notifyObserversDidFinishReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID atURL:(NSURL *)localURL withError:(NSError *)error;
- (void)notifyObserversDidReceiveStream:(NSInputStream *)stream withName:(NSString *)streamName fromPeer:(MCPeerID *)peerID;
@end
