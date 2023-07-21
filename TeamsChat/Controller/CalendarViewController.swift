//
//  CalendarViewController.swift
//  TeamsChat
//
//  Created by Ronak Sankhala on 08/12/22.
//

import UIKit
import CalendarKit
import EventKit
import EventKitUI

class CalendarViewController: DayViewController {

    // MARK: Outlets
    @IBOutlet weak var customNavBar: CustomNavigationBar!

    // MARK: Properties
    let eventRequest = EKEventStore()
    var calendarViewmodel: CalendarViewModel?
    var loadEvents = [EKEventsModel]()
    var alreadyGeneratedSet = Set<Date>()
    var selectedEventModel: EKEventsModel?
    let calendarTitle = NSLocalizedString("Calendar Title", comment: "Localizable")

    var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        return datePicker
    }()

    // Navigate to
    private func presentEventDetailsView(ekEvent: EKEvent) {
        guard let ekViewContoller = calendarViewmodel?.presentEKEventViewController(ekEvent: ekEvent) else { return }
        ekViewContoller.navigationController?.navigationBar.isTranslucent = true
        ekViewContoller.edgesForExtendedLayout = [.all]
        ekViewContoller.delegate = self
        self.navigationController?.pushViewController(ekViewContoller, animated: true)
    }

    // MARK: Override Methods from DayViewController
    override func eventsForDate(_ date: Date) -> [EventDescriptor] {
        let calendarEKEvents = loadEvents.map(EKWrapper.init)
        guard !calendarEKEvents.isEmpty else { return [EventDescriptor]() }
        return calendarEKEvents
    }

    override func dayViewDidSelectEventView(_ eventView: EventView) {
        guard let ckEvent = eventView.descriptor as? EKWrapper else { return }
        selectedEventModel = ckEvent.ekEvent
        guard let ekEvents = calendarViewmodel?.generateEvent(storeEvent: eventRequest, event: ckEvent.ekEvent, calendar: calendar) else { return }
        presentEventDetailsView(ekEvent: ekEvents)
    }
}

// MARK: Override LifeCycle Methods
extension CalendarViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        calendarViewmodel = CalendarViewModel(eventRequest: eventRequest)
        setupUIView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isTranslucent = false
        edgesForExtendedLayout = [.top, .bottom]
    }
}

// MARK: Class Methods
extension CalendarViewController {

    private func loadEventsData() {
        calendarViewmodel?.getEvents { events in
            guard let events = events else { return }
            self.loadEvents = events
            DispatchQueue.main.async {
                self.reloadData()
            }
        }
    }

    // MARK: Setup UI and Ask Permission for Get Events from Calander
    private func setupUIView() {
        self.view.backgroundColor = .white
        title = calendarTitle

        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: datePicker)
        datePicker.addTarget(self, action: #selector(doneDatePickerTap), for: .editingDidEnd)

        dayView.autoScrollToFirstEvent = true
        calendarViewmodel?.requestAccessToCalendar(completion: { isAccess in
            if isAccess {
                // Call this function when Event Chhanged in Calander
                self.calendarViewmodel?.subscribeToEventChangeNotification()
                self.calendarViewmodel?.eventChangeCalled = {(_) in
                    // Reload data once the event changed
                    DispatchQueue.main.async {
                        self.reloadData()
                    }
                }
                self.loadEventsData()
            } else {
                if let alertVC = self.calendarViewmodel?.requestDeniedAlert() {
                    self.navigationController?.present(alertVC, animated: true)
                }
            }
        })
    }

    @objc func doneDatePickerTap() {
      self.view.endEditing(true)
      dayView.move(to: datePicker.date)
      reloadData()
    }
}

extension CalendarViewController: EKEventViewDelegate {
    func eventViewController(_ controller: EKEventViewController, didCompleteWith action: EKEventViewAction) {
        switch action {
        case .deleted:
            if let eventModel = selectedEventModel {
                if let index = loadEvents.firstIndex(of: eventModel) {
                    loadEvents.remove(at: index)
                    reloadData()
                }
            }
        case .responded:
            break
        default:
            break
        }

        controller.navigationController?.popViewController(animated: true)
    }
}
