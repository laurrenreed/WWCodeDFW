//
//  MediumAuthor.swift
//  WWCodeDFW
//
//  Created by Spencer Prescott on 10/18/17.
//  Copyright © 2017 WWCode. All rights reserved.
//

import SwiftyJSON

class MediumAuthor: Model {
    let id: String
    let name: String?
    let username: String?
    let bio: String?
    
    required init?(json: JSON) {
        guard let id = json["userId"].string else { return nil }
        self.id = id
        self.name = json["name"].string
        self.username = json["username"].string
        self.bio = json["bio"].string
    }
}
