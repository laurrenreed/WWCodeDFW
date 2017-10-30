//
//  MediumServiceTests.swift
//  WWCodeDFWTests
//
//  Created by Spencer Prescott on 10/18/17.
//  Copyright © 2017 WWCode. All rights reserved.
//

import XCTest
@testable import WWCodeDFW

class MediumServiceTests: XCTestCase {
    
    private class MockApiService: ApiServicing {
        enum MockError: Error {
            case jsonParseFailure
        }
     
        func load(resource: Resource, responseHandler: @escaping (ApiResult<Model>) -> Void) {
            if let model = mockModel(for: resource as! MediumResource) {
                responseHandler(ApiResult.success(model))
            } else {
                responseHandler(ApiResult.failure(MockError.jsonParseFailure))
            }
        }

        private func mockModel(for resource: MediumResource) -> Model? {
            var filename: String
            switch resource {
            case MediumResource.listPosts:
                filename = "medium_tags_response"
            case MediumResource.fetchPost:
                filename = "medium_post_response"
            }
            if let filepath = Bundle(for: type(of: self)).path(forResource: filename, ofType: "json"), let data = try? Data(contentsOf: URL(fileURLWithPath: filepath)) {
                return resource.parse(responseData: data)
            }
            
            return nil
        }
    }
    
    func testFetchingPostsWithATag() {
        let mockApiService = MockApiService()
        let mediumService = MediumService(apiService: mockApiService)
        
        mediumService.sendRequest(for: .listPosts(tag: "wwcodedfw")) { (response) in
            switch response {
            case .success(let postCollection):
                XCTAssertTrue(postCollection is MediumPostCollection)
            case .failure(_):
                XCTFail("testFetchingPostsWithATag failed to find a MediumPostCollection")
            }
        }
    }
    
    func testFetchingPostFromAuthorAndSlug() {
        let mockApiService = MockApiService()
        let mediumService = MediumService(apiService: mockApiService)
        
        mediumService.sendRequest(for: .fetchPost(username: "laurrenreed_40373", postSlug: "contributing-to-wwcodedfw-ios-project-c9d900bf5c66")) { (response) in
            switch response {
            case .success(let post):
                XCTAssertTrue(post is MediumPost)
            case .failure(_):
                XCTFail("testFetchingPostFromAuthorAndSlug failed to find a MediumPost")
            }
        }
    }
}
