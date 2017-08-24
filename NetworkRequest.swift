//
//  NetworkRequest.swift
//  TemplateSwift3
//
//  Created by Hipolito Arias on 17/08/2017.
//  Copyright © 2017 Hipolito Arias. All rights reserved.
//

import Alamofire

protocol NetworkRequest {
    
    func request(router: URLRequestConvertible,
                 completion: @escaping (Result<Json, NetworkError>) -> Void) -> Void
    
    func request(router: URLRequestConvertible,
                 adapter: RequestAdapter?,
                 completion: @escaping (Result<Json, NetworkError>) -> Void) -> Void
    
    func request( _ url: URL,
                  method: HTTPMethod,
                  parameters: [String: Any]?,
                  headers: [String: String]?,
                  completion: @escaping (Result<Json, NetworkError>) -> Void) -> Void
}
