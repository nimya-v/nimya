//
//  InputBarAccessoryViewMediatorMock.swift
//  TeamsChatTests
//
//  Created by Sameeksha Sharma on 09/04/23.
//

import XCTest
import Combine
@testable import TeamsChat
import InputBarAccessoryView

class InputBarAccessoryViewMediatorMock: InputBarAccessoryViewMediator {
    var recentMessage: String = ""

    override init(sender: Sender, mediator: MessageMediator) {
        super.init(sender: sender, mediator: mediator)
    }

    override func update(messageInputBar: InputBarAccessoryView) {
        super.update(messageInputBar: messageInputBar)
    }

    override func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        guard !text.replacingOccurrences(of: " ", with: "").isEmpty else { return }

        recentMessage = text
    }
}
