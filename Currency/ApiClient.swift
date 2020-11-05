//
//  ApiRequest.swift
//  Currency
//
//  Created by Aaron Lee on 2019/09/18.
//  Copyright © 2019 Aaron Lee. All rights reserved.
//

import Foundation
import Alamofire

typealias CallResponse<T> = ((T) -> Void)?

struct APIRequest {
    
    var requestParam: ApiCallRequest
    
    private var parameters: Parameters {
        get {
            return requestParam.params
        }
    }
    
    private var urlRequest: URLRequest {
        let requestURL = URL(string: "http://apilayer.net/api/\(requestParam.path)")!
        var request = URLRequest(url: requestURL)
        request.httpMethod = "get"
        request.timeoutInterval = 20
        return request
    }
}

extension APIRequest: URLRequestConvertible {
    func asURLRequest() throws -> URLRequest {
        return try URLEncoding.queryString.encode(urlRequest, with: parameters)
    }
}
extension APIRequest: URLConvertible {
    func asURL() throws -> URL {
        return try urlRequest.asURLRequest().url!
    }
}

protocol ResponseHandler {
    static func handleResponse<T: Codable>(_ response: DataResponse<Data>, completion: CallResponse<T>)
}

extension ResponseHandler {
    static func handleResponse<T: Codable>(_ response: DataResponse<Data>, completion: CallResponse<T>) {
        switch response.result {
        case .success(let value):
            do {
                let decoder = JSONDecoder()
                let parsedResponse = try decoder.decode(T.self, from: value)
                completion?(parsedResponse)
            } catch {
                
            }
        case .failure:
            break
        }
    }
}

struct APIManager: ResponseHandler {
    static func execute<T: Codable>(request: ApiCallRequest, completion: CallResponse<T>) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        let apiRequest = APIRequest(requestParam: request)
        Alamofire.request(apiRequest).validate().responseData { response in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            self.handleResponse(response, completion: completion)
        }
    }
}
