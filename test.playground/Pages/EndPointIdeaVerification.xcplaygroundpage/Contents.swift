import UIKit

class URLBuilder {
    
    private var components: URLComponents
    
    init() {
        self.components = URLComponents()
    }
    
    init(withBaseScheme scheme: String, baseHostUrl host: String) {
        self.components = URLComponents()
        self.components.scheme = scheme
        self.components.host = host
    }
    
    func set(scheme: String) -> URLBuilder {
        self.components.scheme = scheme
        return self
    }
    
    func set(host: String) -> URLBuilder {
        self.components.host = host
        return self
    }
    
    func set(port: Int) -> URLBuilder {
        self.components.port = port
        return self
    }
    
    func set(path: String) -> URLBuilder {
        var path = path
        if !path.hasPrefix("/") {
            path = "/\(path)"
        }
        self.components.path = path
        return self
    }
    
    func addQueryItem(name: String, value: String) -> URLBuilder  {
        if self.components.queryItems == nil {
            self.components.queryItems = []
        }
        self.components.queryItems?.append(URLQueryItem(name: name, value: value))
        return self
    }
    
    func build() -> URL? {
        return self.components.url
    }
}

enum HttpMethod: String {
    case get = "GET"
    case head = "HEAD"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
    case connect = "CONNECT"
    case trace = "TRACE"
    case options = "OPTIONS"
}

protocol EndPointProtocol {
    var url: URL? {get set}
    var method: HttpMethod {get}
}

struct AppUrls {
    private static let urlBuilder = URLBuilder().set(scheme: "http").set(host: "myHost")
    
    static func getAppUrl(fromPath path: String) -> URL? {
        return AppUrls.urlBuilder.set(path: path).build()
    }
}

struct LoginEndPoint: EndPointProtocol {
    var url: URL?  = AppUrls.getAppUrl(fromPath: "api/login")
    var method: HttpMethod = .post
}

struct ThirdPartyTestEndPoint: EndPointProtocol {
    var url: URL? = URLBuilder()
        .set(scheme: "https")
        .set(host: "host")
        .set(path: "path")
        .build()
    var method: HttpMethod = .get
}

struct ProfileEndPoint: EndPointProtocol {
    var url: URL?  = AppUrls.getAppUrl(fromPath: "api/profile")
    var method: HttpMethod = .get
}

var profileEndPoint = ProfileEndPoint()

print(LoginEndPoint().url)
print(ThirdPartyTestEndPoint().url)
print(profileEndPoint.url)

let userId = 1
profileEndPoint.url = AppUrls.getAppUrl(fromPath: "api/profile/\(userId)")
print(profileEndPoint.url)


