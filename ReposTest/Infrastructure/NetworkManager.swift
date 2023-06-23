//
//  NetworkManager.swift
//  ReposTest
//
//  Created by Ангеліна Семенченко on 23.06.2023.
//

import Network

final class NetworkManager {
    static let shared = NetworkManager()
    
    private let monitor = NWPathMonitor()
    private(set) var isConnected = true {
        didSet {
            onConnectionChange?(isConnected)
        }
    }

    var onConnectionChange: ((Bool) -> Void)?
    
    private init() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
            }
        }
        
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }
    
    deinit {
        monitor.cancel()
    }
}
