//
//  TeamsViewController.swift
//  TeamsChat
//
//  Created by Ronak Sankhala on 08/12/22.
//

import UIKit

class TeamsViewController: UIViewController {

    @IBOutlet weak var customNavBar: CustomNavigationBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        customNavBar.titleLabel.text = NSLocalizedString("Teams Title", comment: "Localizable")
    }
}
