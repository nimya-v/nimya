//
//  ActivityViewControllerTest.swift
//  TeamsChatTests
//
//  Created by Rohit Chauhan on 07/04/23.
//

import XCTest
@testable import TeamsChat

final class ActivityViewControllerTest: XCTestCase {
    var storyboard: UIStoryboard!
    var sut: ActivityViewController!
    
    override func setUp() {
        storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "ActivityViewController") as! ActivityViewController
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
        storyboard = nil
    }
    
    func test_CallsViewController_WhenCreated_HasRequiredOutlet() throws {
        let customernavigationBar = try XCTUnwrap(sut.customNavigationBar, "The CustomNavigationBar is not connected to an IBOutlet")
        
        XCTAssertNotNil(customernavigationBar)
    }
}
