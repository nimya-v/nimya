//
//  DataViewModel.swift
//  MVVMSample
//
//  Created by Antonio Corrales on 26/6/18.
//  Copyright © 2018 DesarrolloManzana. All rights reserved.
//

import UIKit
import InputBarAccessoryView
import SwiftUI

class ChatViewModel: ObservableObject {

    var chathistory: [ChatHistory]?
    private let fileManager: FileManagerProtocol

    init(chathistory: [ChatHistory]? = nil,
         fileManager: FileManagerProtocol = LocalFileManager()) {
        self.chathistory = chathistory
        self.fileManager = fileManager
    }

    var datas: [Chats] = [Chats]()
    var reloadTableView: (() -> Void)?
    var showError: (() -> Void)?
    var showLoading: (() -> Void)?
    var hideLoading: (() -> Void)?
    @Published var chatlist: [Chats] = []

    func getChats(filename: String = "myJsonFile0", withExtension: String = "json") throws -> [Chats] {
        do {
            if case let .success(data) = try fileManager.data(for: filename, fileExtension: withExtension) {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(ConversationDetails.self, from: data)
                guard !jsonData.chats.isEmpty else {
                    return []
                }
                self.chatlist = jsonData.chats
            }
        } catch {
            throw error.self
        }
        return self.chatlist
    }
}
