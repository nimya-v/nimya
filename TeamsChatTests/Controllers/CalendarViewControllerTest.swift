//
//  CalendarViewControllerTest.swift
//  TeamsChatTests
//
//  Created by Rohit Chauhan on 07/04/23.
//

import XCTest
@testable import TeamsChat

final class CalendarViewControllerTest: XCTestCase {
    var storyboard: UIStoryboard!
    var sut: CalendarViewController!
    
    override func setUp() {
        storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "CalendarViewController") as! CalendarViewController
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
        storyboard = nil
    }
    
    func test_CalendarViewController_WhenCreated_HasRequiredOutlet() throws {
        // ARRANGE
        let customernavigationBar = try XCTUnwrap(sut.customNavBar, "The CustomNavigationBar is not connected to an IBOutlet")
        // ASSERT
        XCTAssertNil(customernavigationBar)
    }
    
}
