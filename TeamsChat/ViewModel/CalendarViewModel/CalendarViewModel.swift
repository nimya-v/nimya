//
//  CalendarViewModel.swift
//  TeamsChat
//
//  Created by Ronak Sankhala on 15/12/22.
//

import Foundation
import CalendarKit
import EventKit
import EventKitUI

class CalendarViewModel {

    var eventRequest: EKEventStore?
    var eventChangeCalled: ((Notification) -> Void)?

    private let calendarAlertTitle = NSLocalizedString("Cal Access Title", comment: "Localizable")
    private let calendarAlertMessage = NSLocalizedString("Cal Access Message", comment: "Localizable")
    private let goToSettingTitle = NSLocalizedString("Go Setting", comment: "Localizable")

    init(eventRequest: EKEventStore? = nil) {
        self.eventRequest = eventRequest
    }

    // MARK: Load events form Json File
    func getEvents(complition: @escaping ApiClient.CallEventsComplition) {
        ApiClient.shared.getCalendarEventsFromJson { events in
            complition(events)
        }
    }

    // MARK: Create new events and return
    func generateEvent(storeEvent: EKEventStore, event: EKEventsModel, calendar: Calendar) -> EKEvent {
        let newEvent = EKEvent(eventStore: storeEvent)
        newEvent.calendar = storeEvent.defaultCalendarForNewEvents
        newEvent.title = event.title
        newEvent.startDate = event.startDate
        newEvent.endDate = event.endDate
        newEvent.timeZone = calendar.timeZone
        newEvent.isAllDay = event.isAllDay
        return newEvent
    }

    // MARK: Temp Store EKEvent data in Model and Update Calendar View
    func generateEKCalendar(event: EKEvent) -> EKEventsModel {
        let newEvent = EKEventsModel(startDate: event.startDate, endDate: event.endDate, isAllDay: event.isAllDay, title: event.title, color: event.calendar.cgColor ?? UIColor.white.cgColor)
        return newEvent
    }

    // MARK: Return Controller with Data and Navigate
    func presentEKEventViewController(ekEvent: EKEvent) -> EKEventViewController {
        let eventViewController = EKEventViewController()
        eventViewController.event = ekEvent
        eventViewController.allowsCalendarPreview = true
        eventViewController.allowsEditing = false
        return eventViewController
    }
}

// MARK: Calander Evnts Permission check
extension CalendarViewModel {
    func requestAccessToCalendar(completion: @escaping ((Bool) -> Void)) {
        switch EKEventStore.authorizationStatus(for: .event) {
        case .authorized:
            completion(true)
        case .notDetermined, .denied:
            eventRequest?.requestAccess(to: .event) { [weak self] (granted, _) in
                guard let _ = self else { return }
                if granted {
                    completion(true)
                } else {
                    completion(false)
                }
            }
        default:
            completion(false)
        }
    }

#if !Testing
    func requestDeniedAlert() -> UIAlertController {
        let requestAlertController = UIAlertController(title: calendarAlertTitle, message: calendarAlertMessage, preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: goToSettingTitle, style: .default){ (action) in
            let goToSettings = URL(string: UIApplication.openSettingsURLString)
            UIApplication.shared.open(goToSettings!)
        }
        requestAlertController.addAction(settingsAction)
        return requestAlertController
    }
#endif

    // MARK: Observable to notify when Event Update or Change
    func subscribeToEventChangeNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(eventChanged(_:)),
                                               name: .EKEventStoreChanged,
                                               object: nil)
    }

    @objc func eventChanged(_ notification: Notification) {
        eventChangeCalled?(notification)
    }
}
