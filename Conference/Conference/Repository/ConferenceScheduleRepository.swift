//
//  ConferenceScheduleRepository.swift
//  Conference
//
//  Created by Pham, Ashley on 8/29/23.
//

import Foundation

class ConferenceScheduleRepository {
    
    private let service: ConferenceScheduleService = ConferenceScheduleService()
    
    init() {}
    
    func getSessions() -> ConferenceSchedule {
        return self.service.getSchedule()
    }
    
    func add(session: Session) {
        self.service.register(session:session)
    }
    
    func remove(session: Session) {
        self.service.unregister(session:session)
    }
}
