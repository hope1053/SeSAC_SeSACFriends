//
//  NetworkConnection.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/05.
//

import Foundation
import Network

class NetworkManager {
    
    static let shared = NetworkManager()
    
    var isReachable: Bool = false
    
    let monitor = NWPathMonitor()
    
    func checkConnection() {
        monitor.pathUpdateHandler = { path in
            
            self.isReachable = path.status == .satisfied
            
            if path.status == .satisfied {
                print("Connected")
            } else {
                print("Disconnected")
            }
            print(path.isExpensive) // Boolean Value that returns true, if the current connection is over cellular or hotspot
        }
        
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
}
