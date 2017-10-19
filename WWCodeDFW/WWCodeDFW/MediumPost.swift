//
//  MediumPost.swift
//  WWCodeDFW
//
//  Created by Spencer Prescott on 10/18/17.
//  Copyright © 2017 WWCode. All rights reserved.
//

class MediumPostPreview: Model {
    let id: String
    let author: MediumAuthor
    
    
    required init?(json: [String: Any]) {
        guard let id = json["id"] as? String,
              let authorJson = json["author"] as? [String: Any],
              let author = MediumAuthor(json: authorJson)
              else { return nil }
        
        self.id = id
        self.author = author
    }
}

class MediumPost: Model {
    required init?(json: [String: Any]) {
        
    }
}
