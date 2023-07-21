//
//  ViewController.swift
//  TeamsChat
//
//  Created by Ronak Sankhala on 07/12/22.
//

import UIKit
import Combine

class ConversationsViewController: UIViewController {

    var chatVM: ChatViewModel?
    @IBOutlet weak var tblConversation: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var customNavigationBar: CustomNavigationBar!
    var chatsDataSourceAndDelegate: ConversationsTableDataSourceAndDelegate?
    private var cancellable: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        chatVM = ChatViewModel(chathistory: nil)
        setupUI()
        initViewModel()
        customNavigationBar.titleLabel.text = NSLocalizedString("Chat Title", comment: "Localizable")
        setupTableView()
    }

    deinit {
        cancellable.removeAll()
    }

    func setupUI() {
        searchBar.backgroundImage = UIImage()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    private func setupTableView() {
        self.chatsDataSourceAndDelegate = ConversationsTableDataSourceAndDelegate()
        if let chatlist = chatVM?.chatlist {
            self.chatsDataSourceAndDelegate?.update(chats: chatlist)
        }
        chatsDataSourceAndDelegate?.tableView = tblConversation
        chatsDataSourceAndDelegate?.navigationController = self.navigationController
        tblConversation.dataSource = chatsDataSourceAndDelegate
        tblConversation.delegate = chatsDataSourceAndDelegate
        let conversationTableViewcell = UINib(nibName: "ReusableConversationTableViewCell",
                                              bundle: nil)
        self.tblConversation.register(conversationTableViewcell,
                                      forCellReuseIdentifier: "ReusableConversationTableViewCell")
        let recentUserChatTableViewcell = UINib(nibName: "RecentChatTableViewCell",
                                              bundle: nil)
        self.tblConversation.register(recentUserChatTableViewcell,
                                      forCellReuseIdentifier: "RecentChatTableViewCell")
        tblConversation.reloadData()
    }
    
    func initViewModel() {
        try? chatVM?.getChats()
    }
}

class ConversationsTableDataSourceAndDelegate: NSObject, UITableViewDataSource, UITableViewDelegate {
    var chatlist: [Chats] = []
    var navigationController: UINavigationController?
    var tableView: UITableView?
    
    init(chatlist: [Chats] = [], navigationController: UINavigationController? = nil, tableView: UITableView? =  nil) {
        self.navigationController = navigationController
    }
    
    func update(chats: [Chats]) {
        self.chatlist = chats
        self.tableView?.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 100
        }
        return 65
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64.0
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return chatlist.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let conversationCell = tableView.dequeueReusableCell(withIdentifier: "RecentChatTableViewCell") as? RecentChatTableViewCell else {
                return UITableViewCell()
            }
            return conversationCell
        } else {
            guard let conversationCell = tableView.dequeueReusableCell(withIdentifier: "ReusableConversationTableViewCell") as? ReusableConversationTableViewCell else {
                return UITableViewCell()
            }
            let item = chatlist[indexPath.row]
            conversationCell.lblUserName.text = item.name
            conversationCell.lblLastMessage.text = item.lastChat
            conversationCell.lblDateTime.text = item.latest_timestamp
            return conversationCell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
