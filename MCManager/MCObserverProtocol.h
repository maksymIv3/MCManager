//
//  MCObserverProtocol.h
//  MCManager
//
//  Created by Maksym Ivanyk on 28.01.2020.
//  Copyright © 2020 Maksym Ivanyk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MultipeerConnectivity/MultipeerConnectivity.h>

@protocol MCObserverProtocol <NSObject>
-(void)didChangeState:(MCSessionState)state peer:(MCPeerID *)peerID;
-(void)didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID;
-(void)didStartReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID withProgress:(NSProgress *)progress;
-(void)didFinishReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID atURL:(NSURL *)localURL withError:(NSError *)error;
-(void)didReceiveStream:(NSInputStream *)stream withName:(NSString *)streamName fromPeer:(MCPeerID *)peerID;
@end

