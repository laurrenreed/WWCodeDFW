//
//  MediumResourceTests.swift
//  WWCodeDFWTests
//
//  Created by Spencer Prescott on 10/18/17.
//  Copyright © 2017 WWCode. All rights reserved.
//

import XCTest
@testable import WWCodeDFW

class MediumResourceTests: XCTestCase {
    
    func testParsingListPosts() {
        let resource = MediumResource.listPosts(tag: "wwcodedfw")
        let filepath = Bundle(for: type(of: self)).path(forResource: "medium_tags_response", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: filepath))
        let json = resource.parse(responseData: data)
    }
    
}
