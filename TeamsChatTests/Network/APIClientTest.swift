//
//  APIClientTest.swift
//  TeamsChatTests
//
//  Created by Rohit Chauhan on 06/04/23.
//

import XCTest
@testable import TeamsChat

final class APIClientTest: XCTestCase {
    var sut: ApiClient?
    
    override func setUpWithError() throws {
        sut = ApiClient.shared
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_calender_events_exist_in_local_jsons_file() {
        // ARRANGE
        var isAvailable: Bool = false
        let expecation = expectation(description: "We expected to have calender events in JSON")
        
        // ACT
        sut?.getCalendarEventsFromJson { events in
            isAvailable = events?.count ?? 0 > 0
            expecation.fulfill()
        }
        
        wait(for: [expecation], timeout: 1.0)
        // ASSERT
        XCTAssertTrue(isAvailable)
    }
}
