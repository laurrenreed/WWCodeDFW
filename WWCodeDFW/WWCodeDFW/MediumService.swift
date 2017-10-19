//
//  MediumService.swift
//  WWCodeDFW
//
//  Created by Spencer Prescott on 10/18/17.
//  Copyright © 2017 WWCode. All rights reserved.
//

import Foundation

enum MediumResource {
    case listPosts(tag: String)
    case fetchPost(id: String)
    
    var endpoint: String {
        switch self {
        case .listPosts(let tag):
            return "tag/\(tag)?format=json"
        case .fetchPost(let id):
            return ""
        }
    }
}

class MediumService {
    private let baseUrl = "https://medium.com/"
    
    func sendRequest(with resource: MediumResource) {
        
    }
}
