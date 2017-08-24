HANetwork
=========
It's a Alamofire basic requestes wrapper

This wrapping can help you to use the `Alamofire` library in a very simple way, Follow the steps:
- Make requests with `URLRequestConvertible`
- Call method from any `ViewController` and receive three possible cases:
    - Success as single object, data response type `[String: Any]`
    - Success as collection of objects, data response type `[String: Any]`
    - Error as tuple of `(NSError, Data)`, if you want parse response body from server.

#### Usage
-------------------
Make `URLRequestConvertible` enum:
```swift

import Alamofire

enum DemoRouter: URLRequestConvertible {
    
    case getPostInfo(parameters: Parameters)
    
    var method: HTTPMethod {
        switch self {
        case .getPostInfo:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getPostInfo:
            return "https://your_url_base/path/path"            
        }
    }
    
    // MARK: URLRequestConvertible
    
    func asURLRequest() throws -> URLRequest {
        let url = try Constants.URL.baseURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .getPostInfo(let parameters):
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        }
        return urlRequest
    }
}
```
Call from ViewController:
1. Instance wrapper:
```swift
var network: RealNetworkRequest = RealNetworkRequest(session: NetworkSessionManager.shared)
```
2. Calling your `URLRequestConvertible`:
```swift 
network.request(router: DemoRouter.getPostInfo(["your_params_here":"param"])) { (result) in            
           
           switch result {                
            case .success(.array (let response)):
                    debugPrint("Single: ----> \(response)")
                
            case .success(.object (let response)):
                    debugPrint("Collection: ----> \(response)")
                
            case .error(.basic (let error)):
                debugPrint("Error: \(error)")
                
            }
        }

```
You have three methods for call Wrapper:
```swift
    // Basic
    func request(router: URLRequestConvertible,
                 completion: @escaping (Result<Json, NetworkError>) -> Void) -> Void
    
    // With RequestAdapter, for custom Headers
    func request(router: URLRequestConvertible,
                 adapter: RequestAdapter?,
                 completion: @escaping (Result<Json, NetworkError>) -> Void) -> Void
    
    // Or more customizable params and data
    func request( _ url: URL,
                  method: HTTPMethod,
                  parameters: [String: Any]?,
                  headers: [String: String]?,
                  completion: @escaping (Result<Json, NetworkError>) -> Void) -> Void
```
