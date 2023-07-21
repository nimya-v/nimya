//
//  ChatHistory.swift
//  TeamsChat
//
//  Created by Capgemini on 14/12/22.
//

import Foundation
import MessageKit

struct ChatHistory: Codable {
    var sender: Sender
    var messageId: String
    var sentDate: String
    var kind: String
}
