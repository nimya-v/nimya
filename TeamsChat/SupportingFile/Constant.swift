//
//  Constant.swift
//  TeamsChat
//
//  Created by Ronak Sankhala on 15/12/22.
//

import Foundation
import UIKit

// MARK: Actionsheet Media Button Types
enum MediaButtonType: String {
    case Photo
    case Video
    case Audio
}

// MARK: Actionsheet Media Source Button Types
enum MediaSourceType: String {
    case PhotoLibrary = "Photo Library"
    case Camera = "Camera"
}

enum AlertFor: String {
    case Media
    case Source
    case Other
}

enum AppType: String {
    case teamsChat = "com.ronaksankhala.TeamsChat"
    case teamsChatSwiftUI = "com.learning.TeamsChat-SwiftUI"
}

struct Constant {
    static func formatter(date: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter.date(from: date) ?? Date()
    }

    static var timeSystem: TimeHourSystem = .twentyFour
    static var bundleIdentifier = Bundle.main.bundleIdentifier
    static var scheme = "$(SCHEME_NAME)"
}

public enum TimeHourSystem: Int {
    @available(swift, deprecated: 0.3.6, obsoleted: 0.3.7, renamed: "twelve")
    case twelveHour = 0
    @available(swift, deprecated: 0.3.6, obsoleted: 0.3.7, renamed: "twentyFour")
    case twentyFourHour = 1
    case twelve = 12
    case twentyFour = 24

    var hours: [String] {
        switch self {
        case .twelveHour, .twelve:
            let array = ["12"] + Array(1...11).map { String($0) }
            let amTemp = array.map { $0 + " AM" } + ["Noon"]
            var pmTemp = array.map { $0 + " PM" }

            pmTemp.removeFirst()
            if let item = amTemp.first {
                pmTemp.append(item)
            }
            return amTemp + pmTemp
        case .twentyFourHour, .twentyFour:
            let array = ["00:00"] + Array(1...24).map { (iTemp) -> String in
                let val = iTemp % 24
                var string = val < 10 ? "0" + "\(val)" : "\(val)"
                string.append(":00")
                return string
            }
            return array
        }
    }

    @available(swift, deprecated: 0.5.8, obsoleted: 0.5.9, renamed: "current")
    public static var currentSystemOnDevice: TimeHourSystem? {
        current
    }

    public static var current: TimeHourSystem? {
        let locale = NSLocale.current
        guard let formatter = DateFormatter.dateFormat(fromTemplate: "j", options: 0, locale: locale) else { return nil }

        if formatter.contains("a") {
            return .twelve
        } else {
            return .twentyFour
        }
    }

    public var format: String {
        switch self {
        case .twelveHour, .twelve:
            return "h:mm a"
        case .twentyFourHour, .twentyFour:
            return "HH:mm"
        }
    }
}

// MARK: Reusabel UIAlertController for Alert and Actionsheet
extension Constant {
    static func Alert(alertFor: AlertFor = .Media, title: String, message: String?, cancelButton: Bool = false, buttonArray: [String]? = nil, style: UIAlertController.Style? = .alert, completionMedia: ((_ mediaType: MediaButtonType) -> Void)? = nil, completionMediaSelection: ((_ mediaType: MediaSourceType) -> Void)? = nil) -> UIAlertController? {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style!)

        guard let buttons = buttonArray else { return nil }

        for buttonName in buttons {
            let button = UIAlertAction(title: buttonName, style: .default, handler: { _ in

                switch alertFor {
                case .Media:
                    // Select option to upload Photo, Video, or Audio
                    guard let completion = completionMedia else { return }
                    let type = MediaButtonType.init(rawValue: buttonName) ?? .Photo
                    completion(type)
                case .Source:
                    // Select Source of Media to select or capture Photo from Library or Camera.
                    guard let completion = completionMediaSelection else { return }
                    let type = MediaSourceType.init(rawValue: buttonName) ?? .Camera
                    completion(type)
                case .Other:
                    break
                    // For Normal Alert controller
                }
            })
            // Added Button to the Alert Controller
            alert.addAction(button)
        }
        // Check if Cncel button is = true, then will add cancel button to the Alert
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        if cancelButton { alert.addAction(cancel) }

        return alert
    }
}
