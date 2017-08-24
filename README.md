# HANetwork
It's a Alamofire basic requestes wrapper

### Make requests
It's simple create new request, only create enum and apply to protocol URLRequestConvertible

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
