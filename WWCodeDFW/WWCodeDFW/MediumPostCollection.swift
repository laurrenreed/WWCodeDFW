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
    let pagingInformation: JSON // If paging is needed later, make a datastructure out of this
    
    required init?(json: JSON) {
        guard let parser = MediumPostCollectionParser(json: json)
            else { return nil }
        
        self.postPreviews = parser.postPreviewsJson.flatMap { MediumPostPreview(json: $0) }
        self.pagingInformation = parser.pagingJson
    }
}
