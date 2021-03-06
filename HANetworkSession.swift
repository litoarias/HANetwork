//
//  SessionManager.swift
//  TemplateSwift3
//
//  Created by Hipolito Arias on 13/07/2017.
//  Copyright © 2017 Hipolito Arias. All rights reserved.
//


import Alamofire

class NetworkSessionManager: SessionManager {
    
    let reachability = NetworkReachabilityManager(host: "www.apple.com")
    
    var reachable: Bool = true
    
    static let shared : NetworkSessionManager = {
        let instance = NetworkSessionManager()
        return instance
    }()
    
    var sessionManager: Alamofire.SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = 30
        
        return Alamofire.SessionManager(configuration: configuration)
    }()
    
    init() {
        super.init()
        reachability?.listener = { [weak self] status in
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
        reachability?.startListening()
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


