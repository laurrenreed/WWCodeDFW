//
//  MediumPostCollectionParser.swift
//  WWCodeDFW
//
//  Created by Spencer Prescott on 10/18/17.
//  Copyright © 2017 WWCode. All rights reserved.
//

import SwiftyJSON

class MediumPostCollectionParser {
    let pagingJson: JSON
    let postPreviewsJson: [JSON]
    
    init?(json: JSON) {
        guard let postsJson = json["value"]["posts"].array else { return nil }
     
        let authorMap = json["references"]["User"]
        let postsArray = postsJson
        let pagingJson = json["paging"]
        
      let postPreviewsJson = postsArray.compactMap { (postJson) -> JSON? in
            guard let authorId = postJson["creatorId"].string else { return nil }
            
            var json = postJson
            json["author"] = authorMap[authorId]
            return json
        }
        
        self.pagingJson = pagingJson
        self.postPreviewsJson = postPreviewsJson
    }
}
