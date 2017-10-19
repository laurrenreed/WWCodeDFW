//
//  MediumAuthor.swift
//  WWCodeDFW
//
//  Created by Spencer Prescott on 10/18/17.
//  Copyright © 2017 WWCode. All rights reserved.
//

import Foundation

class MediumAuthor: Model {
    let id: String
    let name: String?
    let username: String?
    let bio: String?
    
    required init?(json: [String: Any]) {
        guard let id = json["userId"] as? String else { return nil }
        self.id = id
        self.name = json["name"] as? String
        self.username = json["username"] as? String
        self.bio = json["bio"] as? String
    }
}
