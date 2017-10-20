//
//  Model.swift
//  WWCodeDFW
//
//  Created by Spencer Prescott on 10/18/17.
//  Copyright © 2017 WWCode. All rights reserved.
//

import SwiftyJSON

protocol Model {
    init?(json: JSON)
}
