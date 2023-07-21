//
//  LocalFileManagerTest.swift
//  TeamsChatTests
//
//  Created by Rohit Chauhan on 03/04/23.
//

import XCTest
@testable import TeamsChat

final class LocalFileManagerTest: XCTestCase {
    var sut: LocalFileManager?
    
    override func setUpWithError() throws {
        sut = LocalFileManager()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_chats_exist_in_bundle() throws {
       let data = try? sut?.data(for: "myJsonFile0")
       XCTAssertNotNil(data)
    }
    
    func test_events_exist_in_bundle() throws {
        let data = try? sut?.data(for: "events")
        XCTAssertNotNil(data)
    }
    
    func test_chats_not_exist_in_bundle() throws {
        let data = try? sut?.data(for: "myJsonFile01")
        XCTAssertNil(data)
    }
    
    func test_events_not_exist_in_bundle() throws {
        let data = try? sut?.data(for: "events12")
        XCTAssertNil(data)
    }
}
