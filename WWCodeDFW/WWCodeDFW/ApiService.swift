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
    case invalidResourceError
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
    /// HTTP Method the API request will use
    var method: HTTPMethod { get }
    /// URL to send API request to
    var url: URLConvertible { get }
    /// Type of Model the resource will parse the json response into
    var modelType: Model.Type { get }
    /// Hook for determining how json is parsed into the Model
    func parse(responseData: Data) -> Model?
}

protocol ApiServicing {
    /// Makes a network request to the parameterized Resource and responseds with the parsed Model object
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
