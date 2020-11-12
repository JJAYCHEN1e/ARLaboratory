//
//  MultipeerSession.swift
//  ARPlayground
//
//  Created by 陈俊杰 on 10/29/20.
//

import MultipeerConnectivity

class MultipeerSession: NSObject {
    private(set) var serviceType: String!
    
    private(set) var session: MCSession!
    private let myPeerID = MCPeerID(displayName: UIDevice.current.name)
    private var serviceAdvertiser: MCNearbyServiceAdvertiser!
    private var serviceBrowser: MCNearbyServiceBrowser!
    
    private var receivedDataHandler: ((Data, MCPeerID) -> Void)?
    private var peerJoinedHandler: ((MCPeerID) -> Void)?
    private var peerLeftHandler: ((MCPeerID) -> Void)?
    private var peerDiscoveredHandler: ((MCPeerID, [String: String]?) -> Bool)?
    private var peerInvitationdHandler: ((MCPeerID, [String: String]?) -> Bool)?
    
    init(serviceType: String,
         peerType: PeerType,
         receivedDataHandler: ((Data, MCPeerID) -> Void)?,
         peerJoinedHandler: ((MCPeerID) -> Void)?,
         peerLeftHandler: ((MCPeerID) -> Void)?,
         peerDiscoveredHandler: ((MCPeerID, [String: String]?) -> Bool)?,
         peerInvitationdHandler: ((MCPeerID, [String: String]?) -> Bool)?) {
        super.init()
        
        self.serviceType = serviceType
        self.receivedDataHandler = receivedDataHandler
        self.peerJoinedHandler = peerJoinedHandler
        self.peerLeftHandler = peerLeftHandler
        self.peerDiscoveredHandler = peerDiscoveredHandler
        self.peerInvitationdHandler = peerInvitationdHandler
        
        session = MCSession(peer: myPeerID, securityIdentity: nil, encryptionPreference: .required)
        session.delegate = self
        
        if peerType == .host {
            serviceBrowser = MCNearbyServiceBrowser(peer: myPeerID, serviceType: serviceType)
            serviceBrowser.delegate = self
            serviceBrowser.startBrowsingForPeers()
        } else if peerType == .guest {
            let discoveryInfo = ["name": UIDevice.current.name]
            serviceAdvertiser = MCNearbyServiceAdvertiser(peer: myPeerID, discoveryInfo: discoveryInfo, serviceType: serviceType)
            serviceAdvertiser.delegate = self
            serviceAdvertiser.startAdvertisingPeer()
        }
    }
    
    func sendToAllPeers(_ data: Data, reliably: Bool = true) {
        sendToPeers(data, reliably: reliably, peers: connectedPeers)
    }
    
    /// - Tag: SendToPeers
    func sendToPeers(_ data: Data, reliably: Bool, peers: [MCPeerID]) {
        guard !peers.isEmpty else { return }
        do {
            try session.send(data, toPeers: peers, with: reliably ? .reliable : .unreliable)
        } catch {
            print("error sending data to peers \(peers): \(error.localizedDescription)")
        }
    }
    
    var connectedPeers: [MCPeerID] {
        return session.connectedPeers
    }
}

extension MultipeerSession: MCSessionDelegate {
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        if state == .connected {
            peerJoinedHandler?(peerID)
        } else if state == .notConnected {
            peerLeftHandler?(peerID)
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        receivedDataHandler?(data, peerID)
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String,
                 fromPeer peerID: MCPeerID) {
        fatalError("This service does not send/receive streams.")
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String,
                 fromPeer peerID: MCPeerID, with progress: Progress) {
        fatalError("This service does not send/receive resources.")
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String,
                 fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        fatalError("This service does not send/receive resources.")
    }
    
}

extension MultipeerSession: MCNearbyServiceBrowserDelegate {
    
    /// - Tag: FoundPeer
    public func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String: String]?) {
        let accepted = peerDiscoveredHandler?(peerID, info) ?? false
        if accepted {
            browser.invitePeer(peerID, to: session, withContext: try! JSONEncoder().encode(["name": UIDevice.current.name]), timeout: 10)
        }
    }

    public func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        // This app doesn't do anything with non-invited peers, so there's nothing to do here.
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
        print(error)
    }
}

extension MultipeerSession: MCNearbyServiceAdvertiserDelegate {
    
    /// - Tag: AcceptInvite
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID,
                    withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        if let context = context,
           let info = try? JSONSerialization.jsonObject(with: context) as? [String: String] {
            let accepted = peerInvitationdHandler?(peerID, info) ?? false
            
            if accepted {
                // Call the handler to accept the peer's invitation to join.
                invitationHandler(true, self.session)
                return
            }
        }
        
        invitationHandler(false, self.session)
    }
}
