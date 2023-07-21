//
//  TeamsChatUITests.swift
//  TeamsChatUITests
//
//  Created by Sameeksha Sharma on 12/04/23.
//

import XCTest

final class TeamsChatUITests: XCTestCase {
    var app: XCUIApplication!
    
    
    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launch()
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
        app = nil
    }
    
    func test_chat_Page() {
        let tabBar = app.tabBars["Tab Bar"]
        let chatsButton = tabBar.buttons["Chats"]
        chatsButton.tap()
    }
    
    func test_chat_details_page_exists() {
        app.tabBars["Tab Bar"].buttons["Chats"].tap()
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Hollie").element/*[[".cells.containing(.staticText, identifier:\"1985-08-25\").element",".cells.containing(.staticText, identifier:\"Hollie\").element"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
        tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Maridel")/*[[".cells.containing(.staticText, identifier:\"1986-11-07\")",".cells.containing(.staticText, identifier:\"Maridel\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.staticTexts["helloo to you"].swipeDown()
    }
    
    func test_chat_send_one_to_one_message() {
        app.tabBars["Tab Bar"].buttons["Chats"].tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Therine"]/*[[".cells.staticTexts[\"Therine\"]",".staticTexts[\"Therine\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let inputTextfield = app.textViews.containing(.staticText, identifier:"Aa")
        inputTextfield.element.tap()
        inputTextfield.element.typeText("Hi, this is rohit chauhan")
        app.staticTexts["Send"].tap()
    }
    
    func test_send_photo_in_one_to_one_chat() {
        app.tabBars["Tab Bar"].buttons["Chats"].tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Therine"]/*[[".cells.staticTexts[\"Therine\"]",".staticTexts[\"Therine\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["attachements"].tap()
        app/*@START_MENU_TOKEN@*/.scrollViews/*[[".otherElements[\"Attach Media\"].scrollViews",".scrollViews"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.otherElements.buttons["Photo"].tap()
        app/*@START_MENU_TOKEN@*/.scrollViews/*[[".otherElements[\"Attach Photo\"].scrollViews",".scrollViews"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.otherElements.buttons["Photo Library"].tap()
        app/*@START_MENU_TOKEN@*/.scrollViews.otherElements.images["Photo, October 10, 2009, 2:39 AM"]/*[[".otherElements[\"Photos\"].scrollViews.otherElements",".otherElements[\"Photo, March 31, 2018, 12:44 AM, Photo, August 09, 2012, 3:25 AM, Photo, August 09, 2012, 2:59 AM, Photo, August 09, 2012, 12:22 AM, Photo, October 10, 2009, 2:39 AM, Photo, March 13, 2011, 5:47 AM\"].images[\"Photo, October 10, 2009, 2:39 AM\"]",".images[\"Photo, October 10, 2009, 2:39 AM\"]",".scrollViews.otherElements"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
    }
}
