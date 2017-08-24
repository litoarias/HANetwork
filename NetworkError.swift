//
//  NetworkError.swift
//  TemplateSwift3
//
//  Created by Hipolito Arias on 18/8/17.
//  Copyright © 2017 Hipolito Arias. All rights reserved.
//

import Foundation

/// `NetworkError` is the encapsulation Error used in this network layer
///
/// `ErrorObject` Typealias for set name, the type data what return it's a tuple of two values
///  In this exapmple case using three possible cases, you can add more required cases
/// - basicError:     Returned when error basic app, getting body server response what if you want manage data

typealias ErrorObject = (NSError, Data?)

enum NetworkError {
    
    case basicError(_: ErrorObject)
    
    init?(error: NSError, data: Data?) {
        
        let errorObject: ErrorObject = (error, data)
        
        self = .basicError(errorObject)
        
    }
}
