//
//  JsonParser.swift
//  TemplateSwift3
//
//  Created by Hipolito Arias on 17/08/2017.
//  Copyright © 2017 Hipolito Arias. All rights reserved.
//

import Alamofire


/// `HAResponsable` Manage if request is Success or Failure
///
/// `response` It's Alamofire DataReponse Object, what contains all response info
///  - Use response for manage Error or Succes response


protocol HAResponsable {
    
    func parseResponseServer(response: DataResponse<Any>, completion: @escaping (Result<Json, NetworkError>) -> Void)
}

extension HAResponsable where Self: Network {
    
    func parseResponseServer(response: DataResponse<Any>, completion: @escaping (Result<Json, NetworkError>) -> Void) {
        if let value = response.result.value, let result = Json(json: value) {
            completion(.success(result))
            return
        }
        if let error = response.error, let err = NetworkError(error: NSError.parseError(error, body: response.data), data: response.data) {
            completion(.error(err))
            return
        }
        assert(false, "Unknown network error")
    }
    
    
}
