//
//  EKWrapper.swift
//  TeamsChat
//
//  Created by Ronak Sankhala on 15/12/22.
//

import UIKit
import CalendarKit
import EventKit

public final class EKWrapper: EventDescriptor {
    public var dateInterval: DateInterval {
        get {
            return DateInterval(start: ekEvent.startDate, end: ekEvent.endDate)
        }
        set {
            ekEvent.startDate = newValue.start
            ekEvent.endDate = newValue.end
        }
    }

    public var startDate: DateInterval {
        get {
            return DateInterval(start: ekEvent.startDate, end: ekEvent.endDate)
        }
        set {
            ekEvent.startDate = newValue.start
        }
    }

    public var endDate: DateInterval {
        get {
            return DateInterval(start: ekEvent.startDate, end: ekEvent.endDate)
        }
        set {
            ekEvent.endDate = newValue.end
        }
    }

    public var isAllDay: Bool {
        get {
            return ekEvent.isAllDay
        }
        set {
            ekEvent.isAllDay = newValue
        }
    }

    public var text: String {
        get {
            return ekEvent.title
        }
        set {
            ekEvent.title = newValue
        }
    }
    public var attributedText: NSAttributedString?
    public var lineBreakMode: NSLineBreakMode?
    public var color: UIColor {
        return UIColor(cgColor: ekEvent.color)
    }
    public var backgroundColor = SystemColors.systemBlue.withAlphaComponent(0.3)
    public var textColor = SystemColors.label
    public var font = UIFont.boldSystemFont(ofSize: 12)
    public var userInfo: Any?
    public weak var editedEvent: EventDescriptor? {
        didSet {
            updateColors()
        }
    }

    public private(set) var ekEvent: EKEventsModel
    public init(eventKitEvent: EKEventsModel) {
        self.ekEvent = eventKitEvent
        updateColors()
    }

    public func makeEditable() -> EKWrapper {
        let cloned = Self(eventKitEvent: ekEvent)
        cloned.editedEvent = self
        return cloned
    }

    public func commitEditing() {
        guard let edited = editedEvent else {return}
        edited.dateInterval = dateInterval
    }

    func updateColors() {
        // Ternary operator conveted to if else because void functions are not allowed with ternary operators
        applyStandardColors()
    }

    /// Colors used when event is not in editing mode
    private func applyStandardColors() {
        backgroundColor = dynamicStandardBackgroundColor()
        textColor = dynamicStandardTextColor()
    }

    /// Dynamic color that changes depending on the user interface style (dark / light)
    private func dynamicStandardBackgroundColor() -> UIColor {
        let light = backgroundColorForLightTheme(baseColor: color)
        let dark = backgroundColorForDarkTheme(baseColor: color)
        return dynamicColor(light: light, dark: dark)
    }

    /// Dynamic color that changes depending on the user interface style (dark / light)
    private func dynamicStandardTextColor() -> UIColor {
        let light = textColorForLightTheme(baseColor: color)
        return dynamicColor(light: light, dark: color)
    }

    private func textColorForLightTheme(baseColor: UIColor) -> UIColor {
        var hue: CGFloat = 0, sat: CGFloat = 0, brightness: CGFloat = 0, alpha: CGFloat = 0
        baseColor.getHue(&hue, saturation: &sat, brightness: &brightness, alpha: &alpha)
        return UIColor(hue: hue, saturation: sat, brightness: brightness * 0.4, alpha: alpha)
    }

    private func backgroundColorForLightTheme(baseColor: UIColor) -> UIColor {
        baseColor.withAlphaComponent(0.3)
    }

    private func backgroundColorForDarkTheme(baseColor: UIColor) -> UIColor {
        var hue: CGFloat = 0, sat: CGFloat = 0, brightness: CGFloat = 0, alpha: CGFloat = 0
        color.getHue(&hue, saturation: &sat, brightness: &brightness, alpha: &alpha)
        return UIColor(hue: hue, saturation: sat, brightness: brightness * 0.4, alpha: alpha * 0.8)
    }

    private func dynamicColor(light: UIColor, dark: UIColor) -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor { traitCollection in
                let interfaceStyle = traitCollection.userInterfaceStyle
                switch interfaceStyle {
                case .dark:
                    return dark
                default:
                    return light
                }
            }
        } else {
            return light
        }
    }
}
