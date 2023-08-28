//
//  ConferenceScheduleResult.swift
//  Conference
//
//  Created by Pham, Ashley on 9/1/23.
//

import Foundation

enum ConferenceScheduleResult {
    case uninitialized
    case loading
    case success(data: ConferenceSchedule)
    
    var data: ConferenceSchedule {
        switch self {
        case .uninitialized, .loading:
            return ConferenceSchedule(userID: 98765, sessions: [])
        case let .success(data):
            return data
        }
    }
}
