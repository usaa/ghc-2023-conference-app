//
//  ConferenceSchedule.swift
//  Conference
//
//  Created by Pham, Ashley on 8/28/23.
//

import Foundation

struct ConferenceSchedule: Codable {
    let userID: Int
    var sessions: [Session]?
}
