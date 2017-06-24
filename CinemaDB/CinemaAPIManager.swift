//
//  CinemaAPIManager.swift
//  CinemaDB
//
//  Created by Deepak on 6/24/17.
//  Copyright © 2017 Deepak. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

private let BASE_URL = "http://api.themoviedb.org/3/"

typealias ErrorStatus = (Error) -> ()
typealias CompletionHandler = (NSDictionary) -> ()

enum Error: String {
    case APIFailure = "Failed! Please try again later"
    case WrongURL = "Wrong Url format"
    case JSONParsingError = "Error while parsing"
}

class CinemaApiManager {
    class func makeAPICall<T: BaseMappable>(endPoint: HTTPEndPoint, errorStatus: @escaping ErrorStatus, completionHandler: @escaping (T) -> ()) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        guard let url = URL(string: BASE_URL + "\(endPoint.resource)") else {
            errorStatus(.WrongURL)
            return
        }
        print(url.absoluteString)
        request(url, method: endPoint.method, parameters: endPoint.params, encoding: endPoint.encoding, headers: nil).responseObject { (dataResponse :DataResponse<T>) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if let httpResponse = dataResponse.response, httpResponse.statusCode == 200 {
                //Success
                switch dataResponse.result {
                case .success(let value):
                    completionHandler(value)
                case .failure( _):
                    errorStatus(.APIFailure)
                }
            }
        }
    }
}