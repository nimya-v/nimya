//
//  CalendarViewModelTest.swift
//  TeamsChatTests
//
//  Created by Rohit Chauhan on 07/04/23.
//

import XCTest
import Combine
import EventKit
@testable import TeamsChat

final class CalendarViewModelTest: XCTestCase {
    var sut: CalendarViewModel!
    var store: EKEventStore!
    
    override func setUpWithError() throws {
        store = EKEventStore()
        sut = CalendarViewModel(eventRequest: store)
    }

    override func tearDownWithError() throws {
        sut = nil
        store = nil
    }
    
    func test_can_able_to_retrieve_events_from_local_file() {
        // ARRANGE
        let expectation = expectation(description: "Should able to retrieve event from local file")
        var events: [EKEventsModel]?
        
        // ACT
        sut.getEvents { eventList in
            events = eventList
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
        
        // ASSERT
        XCTAssertNotNil(events)
    }
    
    func test_request_access_to_calender() {
        // ARRANGE
        let expectation = expectation(description: "Should provide access to calender")
        var access: Bool = false
        
        // ACT
        sut.requestAccessToCalendar { status in
            access = status
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
        
        // ASSERT
        XCTAssertTrue(access)
        
    }
    
    func test_eKCalendar_event() {
        // ARRANGE
        let newEvent = EKEvent(eventStore: store)
        newEvent.startDate = Date.now
        newEvent.endDate = Date().twoDaysAgo
        newEvent.isAllDay = true
        newEvent.title = "Test Event"
        let calender = EKCalendar(for: .event, eventStore: store)
        calender.cgColor = UIColor.white.cgColor
        newEvent.calendar = calender
        // ACT
        let event = sut.generateEKCalendar(event: newEvent)
        
        // ASSERT
        XCTAssertNotNil(event.startDate)
    }
    
    func test_present_event_event_Controller() {
        // ARRANGE
        let storeEvent = EKEventStore()
        let newEvent = EKEvent(eventStore: storeEvent)
        newEvent.startDate = Date.now
        newEvent.endDate = Date().twoDaysAgo
        newEvent.isAllDay = true
        newEvent.title = "Test Event"
        let calender = EKCalendar(for: .event, eventStore: storeEvent)
        calender.cgColor = UIColor.white.cgColor
        newEvent.calendar = calender
        // ACT
        let presentEventController = sut.presentEKEventViewController(ekEvent: newEvent)
        
        // ASSERT
        XCTAssertTrue(presentEventController.event == newEvent)
    }
    
    func test_event_request() {
        // ARRANGE
        let expectation = expectation(description: "Expected to get request from user")
        var receivedResponse: Bool = false
        // ACT
        sut.requestAccessToCalendar { status in
            receivedResponse = true
            expectation.fulfill()
        }
        // ASSERT
        wait(for: [expectation], timeout: 2.0)
        XCTAssertTrue(receivedResponse)
    }
    
    func test_generate_event_for_calender() {
        // ARRANGE
        let eventModel = EKEventsModel(startDate: Date.now, endDate: Date().fourDaysAgo, isAllDay: true, title: "Test Event", color: UIColor.white.cgColor)
        let event = sut.generateEvent(storeEvent: store, event: eventModel, calendar: Calendar.autoupdatingCurrent)
        
        // ASSERT
        XCTAssertNotNil(event.startDate)
        XCTAssertNotNil(event.endDate)
    }
}
