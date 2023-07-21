//
//  TeamsViewControllerTest.swift
//  TeamsChatTests
//
//  Created by Rohit Chauhan on 07/04/23.
//

import XCTest
@testable import TeamsChat

final class TeamsViewControllerTest: XCTestCase {
    var storyboard: UIStoryboard!
    var sut: TeamsViewController!
    
    override func setUp() {
        storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "TeamsViewController") as! TeamsViewController
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
        storyboard = nil
    }
    
    func test_CallsViewController_WhenCreated_HasRequiredOutlet() throws {
        let customernavigationBar = try XCTUnwrap(sut.customNavBar, "The CustomNavigationBar is not connected to an IBOutlet")
        
        XCTAssertNotNil(customernavigationBar)
    }
}
