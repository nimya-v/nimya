//
//  RecentUserCollectionVIewCellTest.swift
//  TeamsChatTests
//
//  Created by Sameeksha Sharma on 09/04/23.
//

import XCTest
@testable import TeamsChat

final class RecentUserCollectionVIewCellTest: XCTestCase {
    var collectionView: UICollectionView!
    private var dataSource: CollectionViewDataSource!
    private var delegate: CollectionViewDelegate!
    
    override func setUpWithError() throws {
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 200, height: 400), collectionViewLayout: UICollectionViewLayout())
        let itemXib = UINib.init(nibName: "RecentUserCollectionVIewCell",
                                 bundle: nil)
        collectionView.register(itemXib,
                                forCellWithReuseIdentifier: "RecentUserCollectionVIewCell")
        dataSource = CollectionViewDataSource()
        delegate = CollectionViewDelegate()
        collectionView.delegate = delegate
        collectionView.dataSource = dataSource
    }
    
    override func tearDownWithError() throws {
        collectionView = nil
        dataSource = nil
        delegate = nil
    }
    
    func testAwakeFromNib() throws {
        let indexPath = IndexPath(row: 0, section: 0)
        let itemCell = createCell(indexPath: indexPath)
        let imgRecentUser = try XCTUnwrap(itemCell.imgRecentUser)
        let lblRecentUserName = try XCTUnwrap(itemCell.lblRecentUserName)
        
        XCTAssertNotNil(itemCell)
        XCTAssertNotNil(imgRecentUser)
        XCTAssertNotNil(lblRecentUserName)
    }
}

extension RecentUserCollectionVIewCellTest {

func createCell(indexPath: IndexPath) -> RecentUserCollectionVIewCell {
    
    let cell = dataSource.collectionView(collectionView, cellForItemAt: indexPath) as! RecentUserCollectionVIewCell
    XCTAssertNotNil(cell)
    
    let view = cell.contentView
    XCTAssertNotNil(view)
    
    return cell
}
}

private class CollectionViewDataSource: NSObject, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "RecentUserCollectionVIewCell",
            for: indexPath
        )
        return cell
    }
    
    
    var items = [Item]()
    
    override init() {
        super.init()
        
        // Initialize model, i.e. create&add object in items.
    }
}

private class CollectionViewDelegate: NSObject, UICollectionViewDelegate {}
