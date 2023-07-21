//
//  DateTest.swift
//  TeamsChatTests
//
//  Created by Sameeksha Sharma on 09/04/23.
//

import XCTest
@testable import TeamsChat

final class DateTest: XCTestCase {
    var sut:Date!
    
    override func setUpWithError() throws {
        sut = Date()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_date_return_yesterday() {
        let systemReturnYesterday = sut.yesterday
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date().noon)!
        
        XCTAssertTrue(systemReturnYesterday == yesterday)
    }
    
    func test_date_return_twoDaysAgo() {
        let systemReturntwoDaysAgo = sut.twoDaysAgo
        let twoDaysAgo = Calendar.current.date(byAdding: .day, value: -2, to: Date().noon)!
        
        XCTAssertTrue(systemReturntwoDaysAgo == twoDaysAgo)
    }
    
    func test_date_return_threeDaysAgo() {
        let systemReturnthreeDaysAgo = sut.threeDaysAgo
        let threeDaysAgo = Calendar.current.date(byAdding: .day, value: -3, to: Date().noon)!
        
        XCTAssertTrue(systemReturnthreeDaysAgo == threeDaysAgo)
    }
    
    func test_date_return_fourDaysAgo() {
        let systemReturnfourDaysAgo = sut.fourDaysAgo
        let fourDaysAgo = Calendar.current.date(byAdding: .day, value: -4, to: Date().noon)!
        
        XCTAssertTrue(systemReturnfourDaysAgo == fourDaysAgo)
    }
    
    func test_date_return_tomorrow() {
        let systemReturntomorrow = sut.tomorrow
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date().noon)!
        
        XCTAssertTrue(systemReturntomorrow == tomorrow)
    }
    
    func test_date_return_twoHoursAgo() {
        let systemReturntwoHoursAgo = sut.twoHoursAgo
        let twoHoursAgo = Calendar.current.date(byAdding: .hour, value: -2, to: Date().noon)!
        
        XCTAssertTrue(systemReturntwoHoursAgo == twoHoursAgo)
    }
    
    func test_date_return_fiveHoursAgo() {
        let systemReturnfiveHoursAgo = sut.fiveHoursAgo
        let fiveHoursAgo = Calendar.current.date(byAdding: .hour, value: -5, to: Date().noon)!
        
        XCTAssertTrue(systemReturnfiveHoursAgo == fiveHoursAgo)
    }
    
    func test_date_return_month() {
        let systemReturnmonth = sut.month
        let month = Calendar.current.component(.month, from: Date.now)
        
        XCTAssertTrue(systemReturnmonth == month)
    }
    
    func test_date_return_noon() {
        let systemReturnNoon = sut.noon
        let noon = Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: Date.now)!
        
        XCTAssertTrue(systemReturnNoon == noon)
    }
    
    func test_is_last_of_the_month() {
        XCTAssertTrue(sut.isLastDayOfMonth)
    }
}
