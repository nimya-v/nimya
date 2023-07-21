//
//  EKEventsModel.swift
//  TeamsChat
//
//  Created by Ronak Sankhala on 16/12/22.
//

import Foundation
import UIKit

public struct EKEventsModel: Equatable {
    var startDate: Date
    var endDate: Date
    var isAllDay: Bool
    var title: String
    var color: CGColor
}
