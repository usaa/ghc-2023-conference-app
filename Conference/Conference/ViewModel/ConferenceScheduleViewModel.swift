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
        Task {
            await self.loadSchedule()
        }
    }
    
    func loadSchedule() async {
        self.conferenceSchedule = await ConferenceScheduleService().getSchedule()
    }
    
}

