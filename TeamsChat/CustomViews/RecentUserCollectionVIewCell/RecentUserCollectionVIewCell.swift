//
//  RecentUserCollectionVIewCell.swift
//  TeamsChat
//
//  Created by Ronak Sankhala on 10/12/22.
//

import UIKit

class RecentUserCollectionVIewCell: UICollectionViewCell {

    @IBOutlet weak var imgRecentUser: UIImageView!
    @IBOutlet weak var lblRecentUserName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        imgRecentUser.layer.cornerRadius = imgRecentUser.frame.width / 2
    }
}
