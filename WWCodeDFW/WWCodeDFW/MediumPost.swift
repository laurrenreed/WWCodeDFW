//
//  MediumPost.swift
//  WWCodeDFW
//
//  Created by Spencer Prescott on 10/18/17.
//  Copyright © 2017 WWCode. All rights reserved.
//
import Foundation

class MediumPost: Model {
    let id: String
    let title: String
    let slug: String
    let createdAt: Date
    let author: MediumAuthor
    
    required init?(json: [String: Any]) {
        guard let value = json["value"] as? [String: Any],
            let references = json["references"] as? [String: Any],
            let id = value["id"] as? String,
            let title = value["title"] as? String,
            let slug = value["uniqueSlug"] as? String,
            let createdAt = value["createdAt"] as? Int,
            let authorJson = references["User"] as? [String: Any],
            let author = MediumAuthor(json: authorJson),
            let content = value["content"] as? [String: Any]
            else { return nil }
        
        self.id = id
        self.title = title
        self.slug = slug
        self.createdAt = Date(timeIntervalSince1970: Double(createdAt))
        self.author = author
    }
}

class MediumPostParagraph: Model {
    required init?(json: [String: Any]) {
        
    }
}
