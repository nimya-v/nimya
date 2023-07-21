//
//  MessageMediatorMock.swift
//  TeamsChatTests
//
//  Created by Sameeksha Sharma on 09/04/23.
//

import XCTest
import Combine
@testable import TeamsChat
import MessageKit

class MessageMediatorMock: MessageMediator {

    var messageForItem: Message?
    var numberOfSection: Int = -1
    var selectedAvatar: UIImage?
    
    override init(sender: TeamsChat.Sender, messages: [Message]) {
        super.init(sender: sender, messages: messages)
    }

    override func currentSender() -> MessageKit.SenderType {
        return self.sender
    }

    override func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageKit.MessageType {
        messageForItem = messages[indexPath.section]
        return messages[indexPath.section]
    }

    override func numberOfSections(in messagesCollectionView: MessageKit.MessagesCollectionView) -> Int {
        numberOfSection = messages.count
        return messages.count
    }

    override func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        let sender = message.sender

        if sender.senderId == self.sender.senderId {
            // set imgae for Self Sender
            avatarView.image = UIImage(named: "user_profile")
        } else {
            // Set Image for Other User
            avatarView.image = UIImage(named: "otherUser_Profile")
        }
        
        selectedAvatar = avatarView.image
    }

    override func update(collectionView: MessagesCollectionView) {
        self.messagesCollectionView = collectionView
    }

    override func update(messages: [Message]) {
        self.messages = messages
        self.messagesCollectionView?.reloadData()
    }
}
