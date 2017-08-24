//
//  SessionManager.swift
//  TemplateSwift3
//
//  Created by Hipolito Arias on 13/07/2017.
//  Copyright © 2017 Hipolito Arias. All rights reserved.
//


import Alamofire

class NetworkSessionManager: SessionManager {
    
    let manager = NetworkReachabilityManager(host: "www.apple.com")
    
    var reachable: Bool = true
    
    static let shared : NetworkSessionManager = {
        let instance = NetworkSessionManager()
        return instance
    }()
    
    var sessionManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = 30
        let sessionManager = Alamofire.SessionManager(configuration: configuration)
        
        return sessionManager
        
    }()
    
    init() {
        super.init()
        
        manager?.listener = { [weak self] status in
            switch status {
            case .notReachable, .unknown:
                self?.reachable = false
            case .reachable(let connectionType):
                switch connectionType {
                case .ethernetOrWiFi, .wwan:
                    self?.reachable = true
                }
            }
        }
        
        manager?.startListening()
    }
}

extension Request {
    public func debugLog() -> Self {
        #if DEBUG || DEV
            print("Request:\n")
            debugPrint(self)
            print("\n")
        #endif
        return self
    }
}


