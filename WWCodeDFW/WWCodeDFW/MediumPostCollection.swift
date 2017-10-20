//
//  MediumPostCollection.swift
//  WWCodeDFW
//
//  Created by Spencer Prescott on 10/18/17.
//  Copyright © 2017 WWCode. All rights reserved.
//

import SwiftyJSON

class MediumPostCollection: Model {
    let postPreviews: [MediumPostPreview]
    let pagingInformation: JSON // TODO: If paging is needed later, make a datastructure out of this
    
    required init?(json: JSON) {
        guard let postPreviewsJson = json["posts"].array else { return nil }
        
        self.postPreviews = postPreviewsJson.flatMap { MediumPostPreview(json: $0) }
        self.pagingInformation = json["paging"]
    }
}
