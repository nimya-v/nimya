//
//  UIViewControllerExtensionsTest.swift
//  TeamsChatTests
//
//  Created by Sameeksha Sharma on 09/04/23.
//

import XCTest
@testable import TeamsChat

final class UIViewControllerExtensionsTest: XCTestCase {
    var sut: UIWindow!
    
    override func setUpWithError() throws {
        sut = UIApplication
            .shared
            .connectedScenes
            .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
            .last { $0.isKeyWindow }
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_localize_return_right_localized_string_or_not() {
        let isRightConversion = ("Title".localized() == "Teams Chat")
        XCTAssertTrue(isRightConversion)
    }
    
    func presentBuyingErrorDialogue() {
        sut.rootViewController?.showAlert("Test Alert")
    }
    
    func testPresentAlert() throws {
        self.presentBuyingErrorDialogue()
        let expectation = XCTestExpectation(description: "Test Alert")
        let alertController = try XCTUnwrap(self.sut.rootViewController?.presentedViewController as? UIAlertController)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            XCTAssertTrue(self.sut.rootViewController?.presentedViewController is UIAlertController)
            alertController.dismiss(animated: false)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1.5)
    }
}
