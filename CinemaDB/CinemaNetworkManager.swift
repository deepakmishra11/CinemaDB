//
//  CinemaNetworkManager.swift
//  CinemaDB
//
//  Created by Deepak on 6/24/17.
//  Copyright © 2017 Deepak. All rights reserved.
//

import Foundation
import Alamofire

typealias JSONType = [String: Any]
private let API_KEY = "6578a8c2f01a770e74a8fa47e1305842"

/**
 Follow this protocol to design your network API end point
 */
protocol HTTPEndPoint {
    var resource: String {get set}
    var method: Alamofire.HTTPMethod {get set}
    var encoding: Alamofire.URLEncoding {get set}
    var params: JSONType? {get set}
}

struct HTTPEndPointAbstract: HTTPEndPoint {
    var resource: String
    var method: Alamofire.HTTPMethod
    var encoding: Alamofire.URLEncoding
    var params: JSONType?
}

final class EndPointInitializer {
    var params: JSONType = ["api_key": API_KEY]
    var encoding: Alamofire.URLEncoding = .methodDependent
}

protocol HTTPEndPointDSL {
    func GET(resource: String) -> HTTPEndPoint
    func GET(resource: String, initializer: (EndPointInitializer) -> ()) -> HTTPEndPoint
    func POST(resource: String, initializer: (EndPointInitializer) -> ()) -> HTTPEndPoint
}

extension HTTPEndPointDSL {
    func GET(resource: String) -> HTTPEndPoint {
        return HTTPEndPointAbstract(resource: resource,
                                    method: .get,
                                    encoding: .queryString,
                                    params: nil)
    }
    
    func GET(resource: String, initializer: (EndPointInitializer) -> ()) -> HTTPEndPoint {
        let endPointInitializer = EndPointInitializer()
        initializer(endPointInitializer)
        return HTTPEndPointAbstract(resource: resource,
                                    method: .get,
                                    encoding: endPointInitializer.encoding,
                                    params: endPointInitializer.params)
    }
    
    func POST(resource: String, initializer: (EndPointInitializer) -> ()) -> HTTPEndPoint {
        let endPointInitializer = EndPointInitializer()
        initializer(endPointInitializer)
        return HTTPEndPointAbstract(resource: resource,
                                    method: .post,
                                    encoding: .httpBody,
                                    params: endPointInitializer.params)
        
    }
}
