//
//  ApiService.swift
//  WWCodeDFW
//
//  Created by Spencer Prescott on 10/18/17.
//  Copyright © 2017 WWCode. All rights reserved.
//

import Foundation
import Alamofire

enum ApiServiceError: Error {
    case modelParsingError
}

enum ApiResult<T> {
    case success(T)
    case failure(Error)
    
    var value: T? {
        switch self {
        case .success(let value):
            return value
        case .failure:
            return nil
        }
    }
    
    var error: Error? {
        switch self {
        case .success:
            return nil
        case .failure(let error):
            return error
        }
    }
}

protocol Resource {
    var method: HTTPMethod { get }
    var url: URLConvertible { get }
    var modelType: Model.Type { get }
    func parse(responseData: Data) -> Model?
}

protocol ApiServicing {
    func load(resource: Resource, responseHandler: @escaping (ApiResult<Model>) -> Void)
}

class ApiService: ApiServicing {
    static let shared = ApiService()
    
    func load(resource: Resource, responseHandler: @escaping (ApiResult<Model>) -> Void) {
        request(for: resource).responseData { (response) in
            switch response.result {
            case .success(let data):
                if let model = resource.parse(responseData: data) {
                    responseHandler(ApiResult.success(model))
                } else {
                    print("[ApiService] Resource failed to parse model: \(resource)")
                    responseHandler(ApiResult.failure(ApiServiceError.modelParsingError))
                }
            case .failure(let error):
                responseHandler(ApiResult.failure(error))
            }
        }
    }
 
    // MARK: Helpers
    
    private func request(for resource: Resource) -> DataRequest {
        return Alamofire.request(resource.url,
                                 method: resource.method,
                                 parameters: nil,
                                 encoding: parameterEncoding(for: resource),
                                 headers: nil)
    }
    
    private func parameterEncoding(for resource: Resource) -> ParameterEncoding {
        return resource.method == .get
            ? URLEncoding.queryString
            : JSONEncoding.default
    }
}
