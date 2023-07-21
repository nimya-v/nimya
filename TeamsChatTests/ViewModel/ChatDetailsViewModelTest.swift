//
//  ChatDetailsViewModelTest.swift
//  TeamsChatTests
//
//  Created by Rohit Chauhan on 07/04/23.
//

import XCTest
import Combine
@testable import TeamsChat

final class ChatDetailsViewModelTest: XCTestCase {
    var sut: ChatDetailsViewModel!
    var cancellable: Set<AnyCancellable>!
    
    override func setUpWithError() throws {
        sut = ChatDetailsViewModel()
        cancellable = []
    }

    override func tearDownWithError() throws {
        sut = nil
        cancellable.removeAll()
        cancellable = nil
    }
    
    func test_viewmodel_can_retrieve_chat_history_from_local_file() throws {
        let chatHistory = try sut.getChatDetails(id: 1)
        
        XCTAssertNotNil(chatHistory)
    }
    
    func test_viewmodel_should_not_return_chat_for_not_available_chat() throws {
        let chatHistory = try sut.getChatDetails(id: 1000000)
        
        XCTAssertNil(chatHistory)
    }
    
    func test_viewmodel_notify_chat_history_publisher() throws {
        // ARRANGE
        let expectation = expectation(description: "Should notify publisher with chat history data")
        var historyDataCount = -1
        
        // ACT
        sut.$chathistory
            .first()
            .sink { history in
            historyDataCount = history.count
            expectation.fulfill()
        }.store(in: &cancellable)
        
        _ = try sut.getChatDetails(id: 1000000)
        
        // ASSERT
        wait(for: [expectation], timeout: 5.0)
        
        XCTAssertTrue(historyDataCount >= 0)
    }
}
