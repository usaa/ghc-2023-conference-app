//
//  ConferenceScheduleViewModel.swift
//  Conference
//
//  Created by Pham, Ashley on 8/28/23.
//

import Foundation


class ConferenceScheduleViewModel: ObservableObject {
    
    @Published var conferenceSchedule: ConferenceSchedule = ConferenceSchedule(userID: 98765, sessions: [])
    
    init() {
        self.loadSchedule()
    }
    
    func loadSchedule() {
        self.conferenceSchedule = ConferenceScheduleService().getSchedule()
    }
    
}

