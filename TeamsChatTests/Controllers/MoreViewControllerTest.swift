//
//  MoreViewControllerTest.swift
//  TeamsChatTests
//
//  Created by Rohit Chauhan on 07/04/23.
//

import XCTest
@testable import TeamsChat

final class MoreViewControllerTest: XCTestCase {
    var storyboard: UIStoryboard!
    var sut: MoreViewController!
    
    override func setUp() {
        storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "MoreViewController") as! MoreViewController
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
        storyboard = nil
    }
    
    func test_view_loaded_into_hierarchy() {
        XCTAssertNotNil(sut.view)
    }
}
