//
//  TeamsChatUITests.swift
//  TeamsChatUITests
//
//  Created by Sameeksha Sharma on 10/04/23.
//

import XCTest

final class OpenTabsUITests: XCTestCase {
    var app: XCUIApplication!
    
    
    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launch()
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func test_open_activity() throws {
        let tabBar = app.tabBars["Tab Bar"]
        tabBar.buttons["Activity"].tap()
    }
    
    func test_open_chatsList() {
        let tabBar = app.tabBars["Tab Bar"]
        let chatsButton = tabBar.buttons["Chats"]
        chatsButton.tap()
    }

    func test_open_teams() {
        let tabBar = app.tabBars["Tab Bar"]
        tabBar.buttons["Teams"].tap()
    }
    
    func test_open_calendar() {
        let tabBar = app.tabBars["Tab Bar"]
        tabBar.buttons["Calendar"].tap()
    }
    
    func test_open_more_tab() {
        let tabBar = app.tabBars["Tab Bar"]
        tabBar.buttons["More"].tap()
    }
    
    func test_call_page() {
        app.tabBars["Tab Bar"].buttons["More"].tap()
        app.tables.staticTexts["Calls"].tap()
        app.navigationBars["Calls"].buttons["More"].tap()
    }
    
    func test_open_more_page() {
        app.tabBars["Tab Bar"].buttons["More"].tap()
        app.tables.staticTexts["More"].tap()
        app.navigationBars["More"].buttons["More"].tap()
    }
}
