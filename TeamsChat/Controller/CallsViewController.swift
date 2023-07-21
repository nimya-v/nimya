//
//  CallsViewController.swift
//  TeamsChat
//
//  Created by Ronak Sankhala on 08/12/22.
//

import UIKit

class CallsViewController: UIViewController {

    @IBOutlet weak var customNavBar: CustomNavigationBar!
    override func viewDidLoad() {
        super.viewDidLoad()

        customNavBar.titleLabel.text = NSLocalizedString("Calls Title", comment: "Localizable")
    }
}
