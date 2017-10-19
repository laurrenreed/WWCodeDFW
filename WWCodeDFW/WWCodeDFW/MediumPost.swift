//
//  MediumPost.swift
//  WWCodeDFW
//
//  Created by Spencer Prescott on 10/18/17.
//  Copyright © 2017 WWCode. All rights reserved.
//
import Foundation

class MediumPostPreview: Model {
    let id: String
    let title: String
    let slug: String
    let createdAt: Date
    let author: MediumAuthor
    
    
    required init?(json: [String: Any]) {
        guard let id = json["id"] as? String,
              let title = json["title"] as? String,
              let slug = json["uniqueSlug"] as? String,
              let createdAt = json["createdAt"] as? Int,
              let authorJson = json["author"] as? [String: Any],
              let author = MediumAuthor(json: authorJson)
              else { return nil }
        
        self.id = id
        self.title = title
        self.slug = slug
        self.createdAt = Date(timeIntervalSince1970: Double(createdAt))
        self.author = author
    }
}

class MediumPost: Model {
    required init?(json: [String: Any]) {
        
    }
}
