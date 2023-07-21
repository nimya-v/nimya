//
//  ChatDetailsViewModel.swift
//  TeamsChat
//
//  Created by Capgemini on 14/12/22.
//

import Foundation
import SwiftUI

class ChatDetailsViewModel {
    @Published var chathistory: [ChatHistory] = [ChatHistory]()
    private let fileManager: FileManagerProtocol

    init(fileManager: FileManagerProtocol = LocalFileManager()) {
        self.fileManager = fileManager
    }

    func getChatDetails(filename: String = "myJsonFile0", withExtension: String = "json", id: Int) throws -> [ChatHistory]? {
        do {
            let result = try fileManager.data(for: filename, fileExtension: withExtension)

            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(ConversationDetails.self, from: data)
                guard id < jsonData.chats.count else {
                    return nil
                }
                guard !jsonData.chats[id].chat_history.isEmpty else {
                    return nil
                }
                chathistory = jsonData.chats[id].chat_history

            case .failure(_):
                return []
            }
        } catch {
            throw error
        }
        return chathistory
    }
}
