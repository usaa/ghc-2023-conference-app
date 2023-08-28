//
//  MyScheduleViewModel.swift
//  Conference
//
//  Created by Pham, Ashley on 8/29/23.
//

import Foundation

class MyScheduleViewModel: ObservableObject {
    
    @Published var conferenceSchedule: ConferenceSchedule = ConferenceSchedule(userID: 98765, sessions: [])
    
    init() {
        self.loadSchedule()
    }
    
    func loadSchedule() {
        self.conferenceSchedule = ConferenceScheduleRepository().getSessions()
    }
}
