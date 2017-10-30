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
    let paragraphs: [MediumPostParagraph]
    
    required init?(json: JSON) {
        guard let id = json["value"]["id"].string,
            let title = json["value"]["title"].string,
            let slug = json["value"]["uniqueSlug"].string,
            let createdAt = json["value"]["createdAt"].double,
            let creatorId = json["value"]["creatorId"].string,
            let author = MediumAuthor(json: json["references"]["User"][creatorId])
            else { return nil }
        
        self.id = id
        self.title = title
        self.slug = slug
        self.createdAt = Date(timeIntervalSince1970: createdAt)
        self.author = author
        self.paragraphs = (json["value"]["content"]["bodyModel"]["paragraphs"].array ?? [])
            .flatMap { MediumPostParagraph(json: $0) }
    }
}

class MediumPostParagraph: Model {
    let text: String
    let name: String
    
    required init?(json: JSON) {
        guard let text = json["text"].string,
            let name = json["name"].string
            else { return nil}
        
        self.text = text
        self.name = name
    }
}
