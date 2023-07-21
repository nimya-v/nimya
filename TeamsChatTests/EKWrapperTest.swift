//
//  EKWrapperTest.swift
//  TeamsChatTests
//
//  Created by Sameeksha Sharma on 10/04/23.
//

import XCTest
@testable import TeamsChat

final class EKWrapperTest: XCTestCase {
    var sut: EKWrapper!
    
    override func setUpWithError() throws {
        sut = EKWrapper(eventKitEvent: EKEventsModel(startDate: Date.now, endDate: Date().fourDaysAgo, isAllDay: true, title: "Test Event", color: UIColor.white.cgColor))
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_date_interval() {
        // ARRANGE
        let now = Date()
        let tomorrow = now.addingTimeInterval(24.0 * 3600.0)
        let dateInterval = DateInterval(start: now, end: tomorrow)
        sut.dateInterval = dateInterval
        let getinterval = sut.dateInterval
        // ASSERT
        XCTAssertTrue(sut.ekEvent.startDate == now)
        XCTAssertTrue(dateInterval == getinterval)
    }
    
    func test_start_date() {
        // ARRANGE
        let now = Date()
        let tomorrow = now.addingTimeInterval(24.0 * 3600.0)
        let dateInterval = DateInterval(start: now, end: tomorrow)
        sut.dateInterval = dateInterval
        // ASSERT
        XCTAssertTrue(sut.ekEvent.startDate == now)
    }
}
