//
//  MockService.swift
//  ConferenceTests
//
//  Created by Pham, Ashley on 9/5/23.
//

import Foundation
@testable import Conference

class MockService: ConferenceScheduleServiceHandler {
    func getSchedule() async -> Conference.ConferenceScheduleResult {
        return ConferenceScheduleResult.success(data: ConferenceSchedule(userID: 99999,
                                                                         sessions:[
                                Session(id: 1, title: "Mock Session", body: "9:00am - 10:00am", isRegistered: true)
                                ]))
    }
    
    func register(session: Conference.Session) async -> Conference.ConferenceScheduleResult {
        return ConferenceScheduleResult.success(data: ConferenceSchedule(userID: 99999,
                                                                         sessions:[
                                Session(id: 1, title: "Mock Session", body: "9:00am - 10:00am", isRegistered: true)
                                ]))
    }
    
    func unregister(session: Conference.Session) async -> Conference.ConferenceScheduleResult {
        return ConferenceScheduleResult.success(data: ConferenceSchedule(userID: 99999,
                                                                         sessions:[
                                Session(id: 1, title: "Mock Session", body: "9:00am - 10:00am", isRegistered: true)
                                ]))
    }
    
    
}
