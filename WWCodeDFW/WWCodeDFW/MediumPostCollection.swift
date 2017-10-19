//
//  MediumPostCollection.swift
//  WWCodeDFW
//
//  Created by Spencer Prescott on 10/18/17.
//  Copyright © 2017 WWCode. All rights reserved.
//

class MediumPostCollection: Model {
    let postPreviews: [MediumPostPreview]
    let pagingInformation: [String: Any] // TODO: If paging is needed later, make a datastructure out of this
    
    required init?(json: [String: Any]) {
        guard let pagingInformation = json["paging"] as? [String: Any],
              let postPreviewsJson = json["posts"] as? [[String: Any]]
              else { return nil }
        
        self.postPreviews = postPreviewsJson.flatMap { MediumPostPreview(json: $0) }
        self.pagingInformation = pagingInformation
    }
}
