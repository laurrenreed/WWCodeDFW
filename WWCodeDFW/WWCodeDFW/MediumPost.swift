//
//  MediumPost.swift
//  WWCodeDFW
//
//  Created by Spencer Prescott on 10/18/17.
//  Copyright © 2017 WWCode. All rights reserved.
//
import SwiftyJSON

class MediumPost: Model {
    let id: String
    let title: String
    let slug: String
    let createdAt: Date
    let author: MediumAuthor
    
    required init?(json: JSON) {
        guard let id = json["value"]["id"].string,
            let title = json["value"]["title"].string,
            let slug = json["value"]["uniqueSlug"].string,
            let createdAt = json["value"]["createdAt"].double,
            let author = MediumAuthor(json: json["references"]["User"])
            else { return nil }
        
        self.id = id
        self.title = title
        self.slug = slug
        self.createdAt = Date(timeIntervalSince1970: createdAt)
        self.author = author
    }
}
//
//class MediumPostParagraph: Model {
//    required init?(json: [String: Any]) {
//
//    }
//}

