//
//  RecentChatTableViewCell.swift
//  TeamsChat
//
//  Created by Ronak Sankhala on 10/12/22.
//

import UIKit

class RecentChatTableViewCell: UITableViewCell {

    @IBOutlet weak var recentChatCollectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }

    private func setupCollectionView() {
        // Comment if you set Datasource and delegate in .xib
        self.recentChatCollectionView.dataSource = self
        self.recentChatCollectionView.delegate = self

        // Register the xib for collection view cell
        let cellNib = UINib(nibName: "RecentUserCollectionVIewCell", bundle: nil)
        self.recentChatCollectionView.register(cellNib, forCellWithReuseIdentifier: "RecentUserCollectionVIewCell")
    }

}

extension RecentChatTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let recentChatCell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecentUserCollectionVIewCell", for: indexPath) as? RecentUserCollectionVIewCell else {
            return UICollectionViewCell()
        }
        return recentChatCell
    }
}
