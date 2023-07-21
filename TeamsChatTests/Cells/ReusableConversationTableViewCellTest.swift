//
//  ReusableConversationTableViewCellTest.swift
//  TeamsChatTests
//
//  Created by Sameeksha Sharma on 09/04/23.
//

import XCTest
@testable import TeamsChat

final class ReusableConversationTableViewCellTest: XCTestCase {
    var tableView: UITableView!
    private var dataSource: TableViewDataSource!
    private var delegate: TableViewDelegate!
    
    override func setUpWithError() throws {
        tableView = UITableView(frame:  CGRect(x: 0, y: 0, width: 200, height: 400), style: .plain)
        let itemXib = UINib.init(nibName: "ReusableConversationTableViewCell",
                                 bundle: nil)
        tableView.register(itemXib, forCellReuseIdentifier: "ReusableConversationTableViewCell")
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
        let imgUserProfile = try XCTUnwrap(itemCell.imgUserProfile)
        let lblUserName = try XCTUnwrap(itemCell.lblUserName)
        let lblLastMessage = try XCTUnwrap(itemCell.lblLastMessage)
        let lblDateTime = try XCTUnwrap(itemCell.lblDateTime)
        
        XCTAssertNotNil(itemCell)
        XCTAssertNotNil(imgUserProfile)
        XCTAssertNotNil(lblUserName)
        XCTAssertNotNil(lblLastMessage)
        XCTAssertNotNil(lblDateTime)
    }
}

extension ReusableConversationTableViewCellTest {

func createCell(indexPath: IndexPath) -> ReusableConversationTableViewCell {
    
    let cell = dataSource.tableView(tableView, cellForRowAt: indexPath) as! ReusableConversationTableViewCell
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
            withIdentifier: "ReusableConversationTableViewCell",
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
