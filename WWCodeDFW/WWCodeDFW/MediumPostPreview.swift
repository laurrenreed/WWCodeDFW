//
//  MediumPostPreview.swift
//  WWCodeDFW
//
//  Created by Spencer Prescott on 10/19/17.
//  Copyright © 2017 WWCode. All rights reserved.
//

import SwiftyJSON

class MediumPostPreview: Model {
    let id: String
    let title: String
    let slug: String
    let createdAt: Date
    let author: MediumAuthor
    
    
    required init?(json: JSON) {
        guard let id = json["id"].string,
            let title = json["title"].string,
            let slug = json["uniqueSlug"].string,
            let createdAt = json["createdAt"].double,
            let author = MediumAuthor(json: json["author"])
            else { return nil }
        
        self.id = id
        self.title = title
        self.slug = slug
        self.createdAt = Date(timeIntervalSince1970: createdAt)
        self.author = author
    }
}
