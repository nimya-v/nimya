//
//  Chats.swift
//  TeamsChat
//
//  Created by Capgemini on 14/12/22.
//

import Foundation

struct Chats: Codable {
    var id: String
    var name: String
    var picture: String
    var latest_timestamp: String
    var lastChat: String
    var chat_history: [ChatHistory]
}
