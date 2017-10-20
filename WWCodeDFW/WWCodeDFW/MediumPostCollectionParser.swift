//
//  MediumPostCollectionParser.swift
//  WWCodeDFW
//
//  Created by Spencer Prescott on 10/18/17.
//  Copyright © 2017 WWCode. All rights reserved.
//

import SwiftyJSON

class MediumPostCollectionParser {
    let postsArray: [JSON]
    let authorMap: JSON
    let pagingJson: JSON
    
    init?(json: JSON) {
        guard let postsJson = json["payload"]["value"]["posts"].array else { return nil }
     
        self.authorMap = json["payload"]["references"]["User"]
        self.postsArray = postsJson
        self.pagingJson = json["payload"]["paging"]
    }
    
    func parse() -> MediumPostCollection? {
        let postPreviewsJson = postsArray.flatMap { (postJson) -> JSON? in
            guard let authorId = postJson["creatorId"].string else { return nil }
            
            var json = postJson
            json["author"] = authorMap[authorId]
            return json
        }
        
        let json: [String: Any] = [
            "paging": pagingJson,
            "posts": postPreviewsJson
        ]
        
        return MediumPostCollection(json: JSON(json))
    }
}
