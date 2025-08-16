//
//  Constraints.swift
//  Twitter-Clone
//
//  Created by zabakha on 15-08-2025.
//

import Foundation

struct Constants {
    // Get the port from the environment variable or use a fallback.
    static let backendPort: String = {
        let port = ProcessInfo.processInfo.environment["BACKEND_PORT"]
        return port ?? "3000" // Use 3000 as a default if the variable isn't set
    }()
    
    // My Mac's Local Ip Adress on the local network
    static let localIP = "192.168.100.114";
    
    // base URL for server access
    static let baseURL = "http://\(localIP):\(backendPort)"
}
