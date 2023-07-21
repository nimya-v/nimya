//
//  ConstantsTest.swift
//  TeamsChatTests
//
//  Created by Rohit Chauhan on 07/04/23.
//

import XCTest
@testable import TeamsChat

final class ConstantTest: XCTestCase {
    
    override func setUpWithError() throws {
       // Constant only have static properties so, no need Instance management for Constant object
    }

    override func tearDownWithError() throws {
        
    }
    
    func test_constant_should_format_date_from_string_date() {
        // ARRANGE
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let dateStr = formatter.string(from: currentDate)
      
        // ACT
        let date = Constant.formatter(date: dateStr)
        let expectedResult = formatter.date(from: dateStr)
        
       // ASSERT
        XCTAssertEqual(date, expectedResult)
    }
    
    func test_constant_should_not_format_date_from_string_date() {
        // ARRANGE
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateStr = formatter.string(from: currentDate)
      
        // ACT
        let date = Constant.formatter(date: dateStr)
        let expectedResult = formatter.date(from: dateStr)
        
       // ASSERT
        XCTAssertNotEqual(date, expectedResult)
    }
    
    func test_12_hours_time_hours_system() {
        // ARRANGE
        let twelveHoursSystem = TimeHourSystem.twelve
        let expectedTimeSlots = 24
          
        // ACT
        let filter = twelveHoursSystem.hours.filter { $0.hasSuffix("AM") || $0.hasSuffix("PM") }
        
       // ASSERT
        XCTAssertEqual(expectedTimeSlots, filter.count)
    }
    
    func test_24_hours_time_hours_system() {
        // ARRANGE
        let twentyFourHour = TimeHourSystem.twentyFour
        let expectedTimeSlots = 0
          
        // ACT
        let filter = twentyFourHour.hours.filter { $0.hasSuffix("AM") || $0.hasSuffix("PM") }
        
       // ASSERT
        XCTAssertEqual(expectedTimeSlots, filter.count)
    }
    
    func test_current_time_format_is_12_hours() {
        let timeformat = TimeHourSystem.current
        XCTAssertNotNil(timeformat)
        XCTAssertEqual(timeformat, .twelve)
    }
}
