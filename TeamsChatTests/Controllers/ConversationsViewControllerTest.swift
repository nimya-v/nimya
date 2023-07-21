//
//  ConversationsViewControllerTest.swift
//  TeamsChatTests
//
//  Created by Rohit Chauhan on 07/04/23.
//

import XCTest
@testable import TeamsChat

final class ConversationsViewControllerTest: XCTestCase {
    var storyboard: UIStoryboard!
    var sut: ConversationsViewController!
    var mock: ConversationsTableDataSourceAndDelegate!
    var window = UIApplication
        .shared
        .connectedScenes
        .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }.first
    var nav: UINavigationController!
    
    override func setUp() {
        storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "ConversationsViewController") as! ConversationsViewController
        let chatViewModel = ChatViewModel()
        mock = ConversationsTableDataSourceAndDelegate(chatlist: chatViewModel.chatlist)
        sut.chatsDataSourceAndDelegate = mock
        sut.chatVM = chatViewModel
        nav = UINavigationController(rootViewController: sut)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
        storyboard = nil
        mock = nil
        nav = nil
        window = nil
    }
    
    func test_CallsViewController_WhenCreated_HasRequiredOutlet() throws {
        let tblConversation = try XCTUnwrap(sut.tblConversation, "The tblConversation is not connected to an IBOutlet")
        let searchBar = try XCTUnwrap(sut.searchBar, "The searchBar is not connected to an IBOutlet")
        let customNavigationBar = try XCTUnwrap(sut.customNavigationBar, "The customNavigationBar is not connected to an IBOutlet")
        
        XCTAssertNotNil(tblConversation)
        XCTAssertNotNil(searchBar)
        XCTAssertNotNil(customNavigationBar)
    }
    
    func test_init_viewmodel() throws {
        // ARRANGE
        sut.initViewModel()
        let viewModel = try XCTUnwrap(sut.chatVM)
        // ASSERT
        XCTAssertNotNil(viewModel)
    }
    
    func test_update_chat_list() {
        // ARRANGE
        mock.update(chats: [Chats(id: "23", name: "Rohit", picture: "", latest_timestamp: "", lastChat: "", chat_history: [])])
        // ASSERT
        XCTAssertTrue(mock.chatlist.count > 0)
    }
    
    func test_tableView_height_for_section_0() {
        // ARRANGE
        let height = mock.tableView(sut.tblConversation, heightForRowAt: IndexPath(row: 0, section: 0))
        
        // ASSERT
        XCTAssertTrue(height == 100)
    }
    
    func test_tableView_height_for_section_1() {
        // ARRANGE
        let height = mock.tableView(sut.tblConversation, heightForRowAt: IndexPath(row: 0, section: 1))
        
        // ASSERT
        XCTAssertTrue(height == 65)
    }
    
    func test_tableView_number_of_row_for_section_0() {
        // ARRANGE
        let row = mock.tableView(sut.tblConversation, numberOfRowsInSection: 0)
        
        // ASSERT
        XCTAssertTrue(row == 1)
    }
    
    func test_tableView_number_of_row_for_section_1() {
        // ARRANGE
        let row = mock.tableView(sut.tblConversation, numberOfRowsInSection: 1)
        
        // ASSERT
        XCTAssertTrue(row == mock.chatlist.count)
    }
    
    func test_tableView_cell_for_row_0_section_0() {
        // ARRANGE
        let cell = mock.tableView(sut.tblConversation, cellForRowAt: IndexPath(row: 0, section: 0))
        
        // ASSERT
        XCTAssertTrue(cell is RecentChatTableViewCell)
    }
    
    func test_tableView_cell_for_row_0_section_1() {
        // ARRANGE
        mock.update(chats: [Chats(id: "23", name: "Rohit", picture: "", latest_timestamp: "", lastChat: "", chat_history: [])])
        let cell = mock.tableView(sut.tblConversation, cellForRowAt: IndexPath(row: 0, section: 1))
        
        // ASSERT
        XCTAssertTrue(cell is ReusableConversationTableViewCell)
    }
    
    func test_tableView_select_row() throws {
        // ARRANGE
        mock.update(chats: [Chats(id: "23", name: "Rohit", picture: "", latest_timestamp: "", lastChat: "", chat_history: [])])
        mock.tableView(sut.tblConversation, didSelectRowAt: IndexPath(row: 0, section: 1))
        
        // ASSERT
        let controllers = try XCTUnwrap(self.nav.viewControllers)
        XCTAssertTrue(controllers.count > 0)
    }
}
