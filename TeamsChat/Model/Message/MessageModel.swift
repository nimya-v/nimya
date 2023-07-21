//
//  MessageModel.swift
//  TeamsChat
//
//  Created by Ronak Sankhala on 21/12/22.
//

import Foundation
import MessageKit

struct Message: MessageType {
    var sender: MessageKit.SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKit.MessageKind
}

struct Sender: SenderType, Codable {
    var photoURL: String
    var senderId: String
    var displayName: String
}

private enum CodingKeys: String, CodingKey {
    case photoURL
    case senderId
    case displayName
}

struct Media: MediaItem {
    var url: URL?
    var image: UIImage?
    var placeholderImage: UIImage
    var size: CGSize
}
