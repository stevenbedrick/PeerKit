//
//  Advertiser.swift
//  CardsAgainst
//
//  Created by JP Simard on 11/3/14.
//  Copyright (c) 2014 JP Simard. All rights reserved.
//

import Foundation
import MultipeerConnectivity

class Advertiser: NSObject, MCNearbyServiceAdvertiserDelegate {

    let mcSession: MCSession

    init(mcSession: MCSession) {
        self.mcSession = mcSession
        super.init()
    }

    private var advertiser: MCNearbyServiceAdvertiser?

    func startAdvertising(serviceType: String, discoveryInfo: [String: String]? = nil) {
        advertiser = MCNearbyServiceAdvertiser(peer: mcSession.myPeerID, discoveryInfo: discoveryInfo, serviceType: serviceType)
        advertiser?.delegate = self
        advertiser?.startAdvertisingPeer()
    }

    func stopAdvertising() {
        advertiser?.delegate = nil
        advertiser?.stopAdvertisingPeer()
    }


//    @available(iOSApplicationExtension 7.0, *)
//    public func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
//        <#code#>
//    }

    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {

        // keep us from accepting our own invitation?
        print("PEERKIT debug: in didReceiveInvitation fromPeer: \(peerID)")
        print("PEERKIT debug: myPeer displayName: \(mcSession.myPeerID.displayName), hashValue: \(mcSession.myPeerID.displayName.hashValue), raw hash value: \(mcSession.myPeerID.hashValue)")
        print("PEERKIT debug: their peer displayName: \(peerID.displayName), hashValue: \(peerID.displayName.hashValue), raw hash value: \(mcSession.myPeerID.hashValue)")
        
//        let accept = mcSession.myPeerID.displayName.hashValue != peerID.displayName.hashValue
        let accept = true
        
        invitationHandler(accept, mcSession)
        if accept {
            stopAdvertising()
        }
    }
}
