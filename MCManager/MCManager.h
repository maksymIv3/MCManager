//
//  MCManager.h
//  MCManager
//
//  Created by Maksym Ivanyk on 28.01.2020.
//  Copyright © 2020 Maksym Ivanyk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MultipeerConnectivity/MultipeerConnectivity.h>
#import "MCObserverProtocol.h"

@interface MCManager : NSObject <MCSessionDelegate>
@property (nonatomic, strong) MCPeerID *peerID;
@property (nonatomic, strong) MCSession *session;
@property (nonatomic, strong) MCBrowserViewController *browser;
@property (nonatomic, strong) MCAdvertiserAssistant *advertiser;
@property (nonatomic) MCSessionState state;

+(instancetype)shared;
-(void)setupPeerAndSessionWithDisplayName:(NSString *)displayName mcServiceType:(NSString *)mcServiceType;
-(void)setupMCBrowser;
-(void)advertiseSelf:(BOOL)shouldAdvertise;
-(void)addObserver:(id<MCObserverProtocol>)object;
-(void)removeObserver:(id<MCObserverProtocol>)object;
@end
