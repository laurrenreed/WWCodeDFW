//
//  MediumPostCollectionParser.swift
//  WWCodeDFW
//
//  Created by Spencer Prescott on 10/18/17.
//  Copyright © 2017 WWCode. All rights reserved.
//

import Foundation

class MediumPostCollectionParser {
    let postsArray: [[String: Any]]
    let authorMap: [String: Any]
    let pagingJson: [String: Any]
    
    init?(json: [String: Any]) {
        guard let payload = json["payload"] as? [String: Any],
              let references = payload["references"] as? [String: Any],
              let authorMap = references["User"] as? [String: Any],
              let pagingJson = payload["paging"] as? [String: Any],
              let value = payload["value"] as? [String: Any]
              else { return nil }
        
        if let postsArray = value["posts"] as? [[String: Any]] {
            self.authorMap = authorMap
            self.postsArray = postsArray
            self.pagingJson = pagingJson
        } else {
            return nil
        }
    }
    
    func parse() -> MediumPostCollection? {
        let postPreviewsJson = postsArray.flatMap { (postJson) -> [String: Any]? in
            guard let authorId = postJson["creatorId"] as? String,
                  let authorJson = authorMap[authorId] as? [String: Any]
                  else { return nil }
            
            var json = postJson
            json["author"] = authorJson
            return json
        }
        
        let json: [String: Any] = [
            "paging": pagingJson,
            "posts": postPreviewsJson
        ]
        
        return MediumPostCollection(json: json)
    }
}
