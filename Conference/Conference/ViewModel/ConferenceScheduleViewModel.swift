//
//  ConferenceScheduleViewModel.swift
//  Conference
//
//  Created by Pham, Ashley on 8/28/23.
//

import Foundation


class ConferenceScheduleViewModel: ObservableObject {
    
    @Published var conferenceSchedule: ConferenceSchedule = ConferenceSchedule(userID: 98765, sessions: [])
    var service: ConferenceScheduleService
    
    init() {
        self.service = ConferenceScheduleService()
        self.loadSchedule()
    }
    
    func loadSchedule() {
        self.conferenceSchedule = self.service.getSchedule()
    }
    
    func addSession(session: Session) {
        self.service.register(session: session)
    }
    
    func removeSession(session: Session) {
        self.service.unregister(session: session)
    }
    
}

