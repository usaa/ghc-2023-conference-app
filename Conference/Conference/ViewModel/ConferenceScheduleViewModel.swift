//
//  ConferenceScheduleViewModel.swift
//  Conference
//
//  Created by Pham, Ashley on 8/28/23.
//

import Foundation


class ConferenceScheduleViewModel: ObservableObject {
    
    @Published var conferenceSchedule: ConferenceSchedule = ConferenceSchedule(userID: 98765, sessions: [])
    var repository: ConferenceScheduleRepository
    
    init() {
        self.repository = ConferenceScheduleRepository()
        self.loadSchedule()
    }
    
    func loadSchedule() {
        self.conferenceSchedule = self.repository.getSessions()
    }
    
    func addSession(session: Session) {
        self.repository.add(session: session)
    }
    
    func removeSession(session: Session) {
        self.repository.remove(session: session)
    }
    
}

