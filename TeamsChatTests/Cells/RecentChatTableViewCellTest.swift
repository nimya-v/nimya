//
//  RecentChatTableViewCellTest.swift
//  TeamsChatTests
//
//  Created by Sameeksha Sharma on 09/04/23.
//

import XCTest
@testable import TeamsChat

final class RecentChatTableViewCellTest: XCTestCase {
    var tableView: UITableView!
    private var dataSource: TableViewDataSource!
    private var delegate: TableViewDelegate!
    
    override func setUpWithError() throws {
        tableView = UITableView(frame:  CGRect(x: 0, y: 0, width: 200, height: 400), style: .plain)
        let itemXib = UINib.init(nibName: "RecentChatTableViewCell",
                                 bundle: nil)
        tableView.register(itemXib, forCellReuseIdentifier: "RecentChatTableViewCell")
        dataSource = TableViewDataSource()
        delegate = TableViewDelegate()
        tableView.delegate = delegate
        tableView.dataSource = dataSource
    }
    
    override func tearDownWithError() throws {
        tableView = nil
        dataSource = nil
        delegate = nil
    }
    
    func testAwakeFromNib() throws {
        let indexPath = IndexPath(row: 0, section: 0)
        let itemCell = createCell(indexPath: indexPath)
        let recentChatCollectionView = try XCTUnwrap(itemCell.recentChatCollectionView)
        
        XCTAssertNotNil(itemCell)
        XCTAssertNotNil(recentChatCollectionView)
    }
    
    func test_section_return_by_collectionView() throws {
        let indexPath = IndexPath(row: 0, section: 0)
        let itemCell = createCell(indexPath: indexPath)
        let recentChatCollectionView = try XCTUnwrap(itemCell.recentChatCollectionView)
        
        let items = recentChatCollectionView.numberOfItems(inSection: 0)
        
        XCTAssertTrue(items > 0)
    }
    
    func test_collectionView_return_cell_corretly_or_not() throws {
        let indexPath = IndexPath(row: 0, section: 0)
        let itemCell = createCell(indexPath: indexPath)
        let recentChatCollectionView = try XCTUnwrap(itemCell.recentChatCollectionView)
        
        let cell = recentChatCollectionView.dataSource?.collectionView(recentChatCollectionView, cellForItemAt: indexPath)
        XCTAssertNotNil(cell)
    }
}

extension RecentChatTableViewCellTest {

func createCell(indexPath: IndexPath) -> RecentChatTableViewCell {
    
    let cell = dataSource.tableView(tableView, cellForRowAt: indexPath) as! RecentChatTableViewCell
    XCTAssertNotNil(cell)
    
    let view = cell.contentView
    XCTAssertNotNil(view)
    
    return cell
}
}

private class TableViewDataSource: NSObject, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "RecentChatTableViewCell",
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

private class TableViewDelegate: NSObject, UITableViewDelegate {}

