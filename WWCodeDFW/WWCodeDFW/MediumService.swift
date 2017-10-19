//
//  MediumService.swift
//  WWCodeDFW
//
//  Created by Spencer Prescott on 10/18/17.
//  Copyright © 2017 WWCode. All rights reserved.
//

import Foundation
import Alamofire

enum MediumResource: Resource {
    case listPosts(tag: String)
    case fetchPost(id: String)
    
    var url: URLConvertible {
        let baseUrl = "https://medium.com/"
        switch self {
        case .listPosts(let tag):
            return "\(baseUrl)search?q=\(tag.lowercased())&format=json"
        case .fetchPost(let id):
            return "\(baseUrl)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .listPosts, .fetchPost:
            return .get
        }
    }
    
    
    var modelType: Model.Type {
        switch self {
        case .listPosts:
            return MediumPostCollection.self
        case .fetchPost:
            return MediumPost.self
        }
    }
    
    func parse(responseData: Data) -> Model? {
        switch self {
        case .listPosts:
            return parseListPosts(data: responseData)
        case .fetchPost:
            return nil
        }
    }
    
    // MARK: Parsing
    
    private func parseListPosts(data: Data) -> Model? {
        guard let string = String(data: data, encoding: .utf8)
            else { print("[MediumResource] Failed to decode data to string for listing posts"); return nil }
        
        let strippedString = string.replacingOccurrences(of: "])}while(1);</x>", with: "")
        if let strippedData = strippedString.data(using: .utf8),
           let jsonObject = try? JSONSerialization.jsonObject(with: strippedData, options: .allowFragments),
           let json = jsonObject as? [String: Any] {
            return modelType.init(json: json)
        } else {
            print("[MediumResource] Failed to parse json string for listing posts")
            return nil
        }
    }
}

class MediumService {
    private let apiService: ApiServicing
    
    init(apiService: ApiServicing = ApiService.shared) {
        self.apiService = apiService
    }
    
    func sendRequest(for resource: MediumResource, completionHandler: @escaping (ApiResult<Model>) -> Void) {
        apiService.load(resource: resource, responseHandler: completionHandler)
    }
}
