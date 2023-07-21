//
//  ActivityViewController.swift
//  TeamsChat
//
//  Created by Ronak Sankhala on 08/12/22.
//

import UIKit

class ActivityViewController: UIViewController {

    @IBOutlet weak var customNavigationBar: CustomNavigationBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customNavigationBar.titleLabel.text = NSLocalizedString("Activity Title", comment: "Localizable")
    }
}
