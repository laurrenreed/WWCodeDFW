//
//  ApiService.swift
//  WWCodeDFW
//
//  Created by Spencer Prescott on 10/18/17.
//  Copyright © 2017 WWCode. All rights reserved.
//

import Foundation
import Alamofire

enum JSONParseError: Error {
    case parseFailure
}

typealias ApiResponseHandler = (Result<[String: Any]>) -> Void

protocol ApiServicing {
    func load(url: String, method: HTTPMethod, parameters: Parameters?, responseHandler: ApiResponseHandler?)
}

class ApiService: ApiServicing {
    static let shared = ApiService()
    
    func load(url: String, method: HTTPMethod, parameters: Parameters? = nil, responseHandler: ApiResponseHandler?) {
        let encoding: ParameterEncoding = method == .get
            ? URLEncoding.queryString
            : JSONEncoding.default
        Alamofire.request(url, method: method, parameters: parameters, encoding: encoding, headers: nil).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                if let json = value as? [String: Any] {
                    responseHandler?(Result.success(json))
                } else {
                    print("[ApiService] Failed to parse json from response data: \(value)")
                    responseHandler?(Result.failure(JSONParseError.parseFailure))
                }
            case .failure(let error):
                print("[ApiService] Failed to make request for \(url): \(error.localizedDescription)")
                responseHandler?(Result.failure(error))
            }
        }
    }
}
