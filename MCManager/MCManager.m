//
//  MCManager.m
//  MCManager
//
//  Created by Maksym Ivanyk on 28.01.2020.
//  Copyright © 2020 Maksym Ivanyk. All rights reserved.
//

#import "MCManager.h"
#import <MultipeerConnectivity/MultipeerConnectivity.h>
#import "MCObserver.h"

@interface MCManager ()
@property (nonatomic, strong) NSString *mcServiceType;
@property (nonatomic, strong) MCObserver *observer;
@end

@implementation MCManager

+ (instancetype)shared {
    static MCManager *sharedObject = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedObject = [[MCManager alloc] init];
    });
    return sharedObject;
}

- (void)setUpManagerWithMCServiceType:(NSString *)mcServiceType {
    _mcServiceType = mcServiceType;
}

- (MCObserver *)observer {
    if (!_observer) _observer = [[MCObserver alloc] init];
    return _observer;
}

- (void)addObserver:(id<MCObserverProtocol>)object {
    [self.observer addObserver:object];
}

- (void)removeObserver:(id<MCObserverProtocol>)object {
    [self.observer removeObserver:object];
}

-(void)setupPeerAndSessionWithDisplayName:(NSString *)displayName {
    _peerID = [[MCPeerID alloc] initWithDisplayName:displayName];
    
    _session = [[MCSession alloc] initWithPeer:_peerID];
    _state = MCSessionStateNotConnected;
    _session.delegate = self;
}

-(void)setupMCBrowser{
    _browser = [[MCBrowserViewController alloc] initWithServiceType:_mcServiceType session:_session];
}

-(void)advertiseSelf:(BOOL)shouldAdvertise{
    if (shouldAdvertise) {
        _advertiser = [[MCAdvertiserAssistant alloc] initWithServiceType:_mcServiceType
                                                           discoveryInfo:nil
                                                                 session:_session];
        [_advertiser start];
    }
    else{
        [_advertiser stop];
        _advertiser = nil;
    }
}

#pragma mark - MCSessionDelegate

-(void)session:(MCSession *)session peer:(MCPeerID *)peerID didChangeState:(MCSessionState)state{
    _state = state;
    [self.observer notifyObserversDidChangeState:state peer:peerID];
}

-(void)session:(MCSession *)session didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID{
    [self.observer notifyObserversDidReceiveData:data fromPeer:peerID];
}

-(void)session:(MCSession *)session didStartReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID withProgress:(NSProgress *)progress{
    [self.observer notifyObserversDidStartReceivingResourceWithName:resourceName fromPeer:peerID withProgress:progress];
}

-(void)session:(MCSession *)session didFinishReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID atURL:(NSURL *)localURL withError:(NSError *)error{
    [self.observer notifyObserversDidFinishReceivingResourceWithName:resourceName fromPeer:peerID atURL:localURL withError:error];
}

-(void)session:(MCSession *)session didReceiveStream:(NSInputStream *)stream withName:(NSString *)streamName fromPeer:(MCPeerID *)peerID{
    [self.observer notifyObserversDidReceiveStream:stream withName:streamName fromPeer:peerID];
}

@end
