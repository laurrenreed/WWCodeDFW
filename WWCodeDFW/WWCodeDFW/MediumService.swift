//
//  MediumService.swift
//  WWCodeDFW
//
//  Created by Spencer Prescott on 10/18/17.
//  Copyright © 2017 WWCode. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum MediumResource: Resource {
    /// Fetches all post previews with the parameterized tag on Medium
    case listPosts(tag: String)
    /// Fetches the post with the parameterized slug uploaded by the parameterized username
    case fetchPost(username: String, postSlug: String)
    
    var url: URLConvertible {
        let baseUrl = "https://medium.com/"
        switch self {
        case .listPosts(let tag):
            return "\(baseUrl)search?q=\(tag.lowercased())&format=json"
        case .fetchPost(let username, let postSlug):
            return "\(baseUrl)@\(username)/\(postSlug)?format=json"
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
        if let json = parseDataToJson(data: responseData) {
            return modelType.init(json: json["payload"])
        } else {
            print("[MediumResource] Failed to parse json string for resource \(self)")
            return nil
        }
    }
    
    // MARK: Parsing
    
    private func parseDataToJson(data: Data) -> JSON? {
        guard let string = String(data: data, encoding: .utf8)
            else { print("[MediumResource] Failed to decode data to string for listing posts"); return nil }
        
        // strip security json prefix from Medium's json response
        let strippedString = string.replacingOccurrences(of: "])}while(1);</x>", with: "")
        if let strippedData = strippedString.data(using: .utf8) {
            return JSON(data: strippedData)
        }
        
        return nil
    }
}

class MediumService {
    /*
     * This service is used to mock the network request for communicating with Medium
     * Pass this into the apiService parameter for the init method of MediumService to use
     * json fixtures stored on disk instead of actually make a request to Medium's API
     * (ex: let service = MediumService(apiService: MediumService.OfflineTestingApiService()))
     */
    class OfflineTestingApiService: ApiServicing {
        func load(resource: Resource, responseHandler: @escaping (ApiResult<Model>) -> Void) {
            guard let mediumResource = resource as? MediumResource else {
                assertionFailure("[OfflineTestingApiService] Requires parameterized resource to be of type MediumResource")
                responseHandler(ApiResult.failure(ApiServiceError.invalidResourceError))
                return
            }
            if let model = mockModel(for: mediumResource) {
                responseHandler(ApiResult.success(model))
            } else {
                responseHandler(ApiResult.failure(ApiServiceError.modelParsingError))
            }
        }
        
        private func mockModel(for resource: MediumResource) -> Model? {
            var filename: String
            switch resource {
            case MediumResource.listPosts:
                filename = "medium_tags_response"
            case MediumResource.fetchPost:
                filename = "medium_post_response"
            }
            if let filepath = Bundle(for: type(of: self)).path(forResource: filename, ofType: "json"),
                let data = try? Data(contentsOf: URL(fileURLWithPath: filepath)) {
                return resource.parse(responseData: data)
            }
            
            return nil
        }
    }
    
    private let apiService: ApiServicing
    
    init(apiService: ApiServicing = ApiService.shared) {
        self.apiService = apiService
    }
    
    /// Makes a network call to Medium for the parameterized resource and parses the response into a Model
    func sendRequest(for resource: MediumResource, completionHandler: @escaping (ApiResult<Model>) -> Void) {
        apiService.load(resource: resource, responseHandler: completionHandler)
    }
}
