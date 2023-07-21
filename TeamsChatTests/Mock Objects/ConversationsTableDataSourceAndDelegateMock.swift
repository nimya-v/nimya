//
//  ConversationsTableDataSourceAndDelegateMock.swift
//  TeamsChatTests
//
//  Created by Sameeksha Sharma on 10/04/23.
//

import XCTest
@testable import TeamsChat

class ConversationsTableDataSourceAndDelegateMock:ConversationsTableDataSourceAndDelegate {
    var heightForRow: UInt = 0
    var numberOfSections: UInt = 0
    var cellCreation: Bool = false
    var selectedCell: Bool = false
     
    override init(chatlist: [Chats] = [], navigationController: UINavigationController? = nil, tableView: UITableView? =  nil) {
        super.init(chatlist: chatlist, navigationController: navigationController, tableView: tableView)
    }
    
    override func update(chats: [Chats]) {
        self.chatlist = chats
        self.tableView?.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            heightForRow = 100
            return 100
        } else {
            heightForRow = 65
            return 65
        }
    }

    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64.0
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        numberOfSections = 2
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return chatlist.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let conversationCell = tableView.dequeueReusableCell(withIdentifier: "RecentChatTableViewCell") as? RecentChatTableViewCell else {
                return UITableViewCell()
            }
            cellCreation = true
            return conversationCell
        } else {
            guard let conversationCell = tableView.dequeueReusableCell(withIdentifier: "ReusableConversationTableViewCell") as? ReusableConversationTableViewCell else {
                return UITableViewCell()
            }
            let item = chatlist[indexPath.row]
            conversationCell.lblUserName.text = item.name
            conversationCell.lblLastMessage.text = item.lastChat
            conversationCell.lblDateTime.text = item.latest_timestamp
            cellCreation = true
            return conversationCell
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCell = true
        let ChatVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChatViewController") as? ChatViewController
        let item = chatlist[indexPath.row]
        let sender = Sender(photoURL: "", senderId: "1", displayName: "Hardik Sankhala")
        let mediator = MessageMediator(sender: sender, messages: [])
        ChatVC?.mediator = mediator
        ChatVC?.inputbarMediator = InputBarAccessoryViewMediator(sender: sender, mediator: mediator)
        ChatVC?.imagePickerMediator = ImagePickerMediator(sender: sender, mediator: mediator)
        ChatVC?.title = item.name
        ChatVC?.chatid = indexPath.row
        ChatVC?.chathistory = item.chat_history
        navigationController?.pushViewController(ChatVC!, animated: true)
    }
}
