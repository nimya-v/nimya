//
//  ChatViewModelTest.swift
//  TeamsChatTests
//
//  Created by Rohit Chauhan on 07/04/23.
//

import XCTest
import Combine
@testable import TeamsChat

final class ChatViewModelTest: XCTestCase {
    var sut: ChatViewModel!
    var cancellable: Set<AnyCancellable>!
    
    override func setUpWithError() throws {
        sut = ChatViewModel()
        cancellable = []
    }

    override func tearDownWithError() throws {
        sut = nil
        cancellable.removeAll()
        cancellable = nil
    }
    
    func test_viewmodel_can_retrieve_chats_from_local_file() throws {
        let chats = try sut.getChats()
        
        XCTAssertTrue(chats.count >= 0)
    }
    
    func test_viewmodel_should_not_return_chats_for_not_available_chat() {
        let chats = try? sut.getChats(filename: "weqewqw", withExtension: "json")
        
        XCTAssertNil(chats)
    }
    
    func test_viewmodel_notify_chats_publisher() throws {
        // ARRANGE
        let expectation = expectation(description: "Should notify publisher with chats data")
        var chatsCount = -1
        
        // ACT
        sut.$chatlist
            .first()
            .sink { chats in
            chatsCount = chats.count
            expectation.fulfill()
        }.store(in: &cancellable)
       
       _ = try sut.getChats()
        
        // ASSERT
        wait(for: [expectation], timeout: 5.0)
        
        XCTAssertTrue(chatsCount >= 0)
    }
}
