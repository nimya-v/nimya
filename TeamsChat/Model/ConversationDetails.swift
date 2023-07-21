//
//  ConversationDetails.swift
//  TeamsChat
//
//  Created by Capgemini on 14/12/22.
//

import Foundation

struct ConversationDetails: Codable {
    var photoURL: String
    var senderId: String
    var displayName: String
    var chats: [Chats]
}
