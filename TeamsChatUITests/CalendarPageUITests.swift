//
//  CalendarPageUITests.swift
//  TeamsChatUITests
//
//  Created by Sameeksha Sharma on 12/04/23.
//

import XCTest

final class CalendarPageUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        app = XCUIApplication()
        continueAfterFailure = false
        app.launch()
    }
    
    override func tearDownWithError() throws {
        app = nil
    }
    
    func test_calendar_page_exist() {
        let tabBar = app.tabBars["Tab Bar"]
        tabBar.buttons["Calendar"].tap()
    }
    
    func test_calendar_validate_event_details_page() {
        app.tabBars["Tab Bar"].buttons["Calendar"].tap()
        app.scrollViews.otherElements.scrollViews.otherElements.scrollViews.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .textView).element.tap()
    }
    
    func test_select_event_day_with_date_22_dec_2022() {
        let app = XCUIApplication()
        app.tabBars["Tab Bar"].buttons["Calendar"].tap()
        
        let elementsQuery = app.scrollViews.otherElements
        
        let element2 = app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 0)
        let element = element2.scrollViews.children(matching: .other).element.children(matching: .other).element
        
        while true {
            let textElement = app.staticTexts["Wednesday, December 21, 2022"]
            if textElement.exists {
                 break
            }
            
            element.swipeRight()
        }
        
        elementsQuery.buttons["22"].tap()
        elementsQuery.scrollViews.children(matching: .other).element(boundBy: 0).children(matching: .other).element.children(matching: .textView).element.tap()
        
    }
    
    func test_2() {
        
        let app = XCUIApplication()
        app.tabBars["Tab Bar"].buttons["Calendar"].tap()
        
        let elementsQuery = app.scrollViews.otherElements
        elementsQuery.buttons["11"].tap()
        
        let button = elementsQuery.buttons["10"]
        button.swipeRight()
        button.tap()
        
        let button2 = elementsQuery.buttons["9"]
        button2.tap()
        app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 0).scrollViews.children(matching: .other).element.children(matching: .other).element.swipeRight()
        button2.swipeRight()
        elementsQuery.buttons["8"].tap()
        
        
    }
}
