//
//  MediumResourceTests.swift
//  WWCodeDFWTests
//
//  Created by Spencer Prescott on 10/19/17.
//  Copyright © 2017 WWCode. All rights reserved.
//

import XCTest
@testable import WWCodeDFW

class MediumResourceTests: XCTestCase {
    
    func testParsingJsonOfPost() {
        let filename = "medium_post_response"
        let filepath = Bundle(for: type(of: self)).path(forResource: filename, ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: filepath))
        
        let resource = MediumResource.fetchPost(username: "username", postSlug: "slug")
        guard let post = resource.parse(responseData: data) as? MediumPost else {
            XCTFail("MediumResource for fetching a post did not parse json response into a MediumPost Model object")
            return
        }
        
        XCTAssertEqual(post.paragraphs.count, 9)
        XCTAssertEqual(post.author.id, "4a0336cf4eb9")
        XCTAssertEqual(post.id, "c9d900bf5c66")
        XCTAssertEqual(post.slug, "contributing-to-wwcodedfw-ios-project-c9d900bf5c66")
        XCTAssertEqual(post.title, "Contributing to WWCodeDFW iOS Project")
        XCTAssertEqual(post.createdAt, Date(timeIntervalSince1970: 1507572363508.0))
    }
    
    func testParsingJsonOfPostsWithTag() {
        let filename = "medium_tags_response"
        let filepath = Bundle(for: type(of: self)).path(forResource: filename, ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: filepath))
    
        let resource = MediumResource.listPosts(tag: "tag")
        guard let postCollection = resource.parse(responseData: data) as? MediumPostCollection else {
            XCTFail("MediumResource for fetching a list of posts with tag did not parse json response into a MediumPostCollection Model object")
            return
        }
    
        
        XCTAssertEqual(postCollection.postPreviews.count, 3)
        let firstPostPreview = postCollection.postPreviews.first!
        
        XCTAssertEqual(firstPostPreview.id, "c9d900bf5c66")
        XCTAssertEqual(firstPostPreview.title, "Contributing to WWCodeDFW iOS Project")
        XCTAssertEqual(firstPostPreview.slug, "contributing-to-wwcodedfw-ios-project-c9d900bf5c66")
        XCTAssertEqual(firstPostPreview.createdAt, Date(timeIntervalSince1970: 1507572363508.0))
    }
}
