//
//  ApitClient.swift
//  TeamsChat
//
//  Created by Ronak Sankhala on 07/12/22.
//

import Foundation
import EventKit
import CalendarKit

class ApiClient {

    static let shared = ApiClient()
    private init() {}

    typealias CallEventsComplition = (([EKEventsModel]?) -> Void)

    func getCalendarEventsFromJson( completion: @escaping CallEventsComplition) {
        let colors = [UIColor.blue,
                      UIColor.yellow,
                      UIColor.green,
                      UIColor.red]
        DispatchQueue.global().async {
            let decoder = JSONDecoder()

            guard let path = Bundle.main.path(forResource: "events", ofType: "json"),
                  let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe),
                  let result = try? decoder.decode(CalendarModel.self, from: data) else { return }

            let events = result.data.compactMap({ (item) -> EKEventsModel in
                let startDate = Constant.formatter(date: item.start)
                let endDate = Constant.formatter(date: item.end)

                let eventBox = EKEventsModel(startDate: startDate, endDate: endDate, isAllDay: item.allDay, title: item.title, color: colors.randomElement()!.cgColor)

                return eventBox
            })
            completion(events)
        }
    }
}
