//
//  ChatViewControllerTests.swift
//  TeamsChatTests
//
//  Created by Rohit Chauhan on 07/04/23.
//

import MessageKit
import InputBarAccessoryView
import XCTest
@testable import TeamsChat

final class ChatViewControllerTests: XCTestCase {
    var storyboard: UIStoryboard!
    var sut: ChatViewController!
    var navC: UINavigationController!
    var messageMediatorMock: MessageMediator!
    var imagePickerMediatorMock:ImagePickerMediatorMock!
    var inputBarAccessoryViewMediatorMock: InputBarAccessoryViewMediator!
    var window = UIApplication
        .shared
        .connectedScenes
        .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
        .last { $0.isKeyWindow }
    
    override func setUp() {
        storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        let sender = Sender(photoURL: "", senderId: "1", displayName: "Hardik Sankhala")
        messageMediatorMock = MessageMediator(sender: sender, messages: [])
        inputBarAccessoryViewMediatorMock = InputBarAccessoryViewMediator(sender: sender, mediator: messageMediatorMock)
        imagePickerMediatorMock = ImagePickerMediatorMock(sender: sender, mediator: messageMediatorMock)
        sut.mediator = messageMediatorMock
        sut.inputbarMediator = inputBarAccessoryViewMediatorMock
        sut.imagePickerMediator = imagePickerMediatorMock
        navC = UINavigationController(rootViewController: sut)
        window?.rootViewController = navC
        window?.makeKeyAndVisible()
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
        storyboard = nil
        navC = nil
        messageMediatorMock = nil
        imagePickerMediatorMock = nil
        inputBarAccessoryViewMediatorMock = nil
        window = nil
    }
        
    func test_ChatViewController_WhenCreated_HasRequiredOutlet() throws {
        let customernavigationBar = try XCTUnwrap(sut.customNavigationBar, "The CustomNavigationBar is not connected to an IBOutlet")
        XCTAssertNotNil(customernavigationBar)
    }
    
    func test_ChatViewController_WhenCreated_HasChatViewModel() throws {
        let chatViewModel = sut.chatVM
        XCTAssertNotNil(chatViewModel)
    }
    
    func test_viewWillAppear_called_correctly() throws {
        let navbar = try XCTUnwrap(sut.navigationController?.navigationBar)
        
        XCTAssertNotNil(navbar)
        XCTAssertFalse(navbar.isHidden)
    }
    
    func test_left_button_set_correctly_into_inputBarAccessoryView() {
        XCTAssertTrue(sut.messageInputBar.leftStackView.arrangedSubviews.count > 0)
    }
    
    func test_present_actionSheet() throws {
        // ARRANGE
        let button = sut.messageInputBar.leftStackView.arrangedSubviews.filter { $0 is InputBarButtonItem }.first as? InputBarButtonItem
        let attachementButton: InputBarButtonItem = try XCTUnwrap(button)
        // ACT
        let attachementButtonActions = try XCTUnwrap(attachementButton.actions(forTarget: attachementButton, forControlEvent: .touchUpInside), "Attachement button does not have any actions assigned to it")
        // ASSERT
        XCTAssertEqual(attachementButtonActions.count, 1)
    }
    
    func test_setupMessageCollectionView_method_with_mediator_nil() {
        // ARRANGE
        let sender = Sender(photoURL: "", senderId: "1", displayName: "Hardik Sankhala")
        let messageMediatorMock = MessageMediatorMock(sender: sender, messages: [])
        sut.chatVM = ChatViewModel(chathistory: [])
        sut.setupMessageCollectionView(messageMediator: nil)
        
        // ASSERT
        XCTAssertNil(sut.messagesCollectionView.messagesDataSource)
        XCTAssertNil(sut.messagesCollectionView.messagesLayoutDelegate)
        XCTAssertNil(sut.messagesCollectionView.messagesDisplayDelegate)
    }
    
    func test_setupMessageCollectionView_method_with_set_mediator() {
        // ARRANGE
        let sender = Sender(photoURL: "", senderId: "1", displayName: "Hardik Sankhala")
        let messageMediatorMock = MessageMediatorMock(sender: sender, messages: [])
        sut.chatVM = ChatViewModel(chathistory: [])
        sut.setupMessageCollectionView(messageMediator: messageMediatorMock)
        
        // ASSERT
        XCTAssertNotNil(sut.messagesCollectionView.messagesDataSource)
        XCTAssertNotNil(sut.messagesCollectionView.messagesLayoutDelegate)
        XCTAssertNotNil(sut.messagesCollectionView.messagesDisplayDelegate)
        XCTAssertNotNil(sut.messageInputBar.delegate)
    }
    
    func test_navigation_bar_setup() throws {
        // ARRANGE
        sut.setupNavigationBar()
        
        // ASSERT
        let callback = try XCTUnwrap(sut.customNavigationBar.backButtonTapped)
        callback()
        XCTAssertNotNil(callback)
    }
    
    func test_message_from_message_mediator() {
        // ARRANGE
        let sender = Sender(photoURL: "", senderId: "1", displayName: "Hardik Sankhala")
        messageMediatorMock.messages = [Message(sender: sender, messageId: "erwe", sentDate: Date.now, kind: .text("ROhit"))]
         let message = messageMediatorMock.messageForItem(at: IndexPath(row: 0, section: 0), in: sut.messagesCollectionView)
        
        // ASSERT
        XCTAssertNotNil(message)
    }
    
    func test_message_currenSender() {
        // ARRANGE
        let currentSender = messageMediatorMock.currentSender()
        
        // ASSERT
        XCTAssertNotNil(currentSender.senderId == "1")
    }
    
    func test_number_of_section() {
        // ARRANGE
        let sender = Sender(photoURL: "", senderId: "1", displayName: "Hardik Sankhala")
        messageMediatorMock.messages = [Message(sender: sender, messageId: "erwe", sentDate: Date.now, kind: .text("ROhit"))]
        let section = messageMediatorMock.numberOfSections(in: sut.messagesCollectionView)
        
        // ASSERT
        XCTAssertNotNil(section > 0)
    }
    
    func test_configure_avatar() {
        // ARRANGE
        let avatar: AvatarView = AvatarView()
        let sender = Sender(photoURL: "", senderId: "1", displayName: "Hardik Sankhala")
        let message = Message(sender: sender, messageId: "erwe", sentDate: Date.now, kind: .text("ROhit"))
        messageMediatorMock.messages = [message]
        messageMediatorMock.configureAvatarView(avatar, for: message, at: IndexPath(row: 0, section: 0), in: sut.messagesCollectionView)
        
        // ASSERT
        XCTAssertNotNil(avatar.image)
    }
    
    func test_append_history() {
        // ARRANGE
        let sender = Sender(photoURL: "", senderId: "1", displayName: "Hardik Sankhala")
        sut.appendChatHistory(with: [ChatHistory(sender: sender, messageId: "werer", sentDate: "10/04/2023", kind: "sdfse")])
        // ASSERT
        XCTAssertTrue(sut.messages.count == 1)
    }
    
    func test_input_accessory_view() {
        // ARRANGE
        inputBarAccessoryViewMediatorMock.inputBar(InputBarAccessoryView(), didPressSendButtonWith: "Test Input")
        
        // ASSERT
        XCTAssertTrue(sut.messages.count > 0)
    }
}
