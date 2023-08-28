//
//  ConferenceScheduleService.swift
//  Conference
//
//  Created by Pham, Ashley on 8/29/23.
//

import Foundation

class ConferenceScheduleService {
    var conferenceSchedule: ConferenceSchedule
    
    init() {
        self.conferenceSchedule = ConferenceSchedule(userID: 98765,
                                                     sessions:[
            Session(id: 1, title: "Intro To Mobile Design Patterns", body: "9:00am - 10:00am", isRegistered: true),
            Session(id: 2, title: "Navigation Patterns", body: "10:15am - 11:00am", isRegistered: true),
            Session(id: 3, title: "Fun with Flags", body: "11:15am - 12:00pm", isRegistered: false),
            Session(id: 4, title: "Form Design for Mobile", body: "1:15pm - 2:00pm", isRegistered: false),
            Session(id: 5, title: "Onboarding Techniques", body: "2:15pm - 3:00pm", isRegistered: false),
            Session(id: 6, title: "Accessibility In Mobile", body: "3:15pm - 4:00pm", isRegistered: false),
            Session(id: 7, title: "Dark Mode and Theming", body: "4:15pm - 5:00pm", isRegistered: false),
            Session(id: 8, title: "Micro interactions", body: "5:15pm - 6:00pm", isRegistered: false),
            Session(id: 9, title: "Mobile UX 101", body: "6:15pm - 7:00pm", isRegistered: false),
            Session(id: 10, title: "Design With You in Mind", body: "7:15pm - 8:00pm", isRegistered: false)
            ])
    }
    
    func getSchedule() -> ConferenceSchedule {
        return self.conferenceSchedule
    }
    
    func register(session: Session) -> ConferenceSchedule {
        if let s = self.conferenceSchedule.sessions?.firstIndex(of: session) {
            var registerSession = session
            registerSession.isRegistered = true
            self.conferenceSchedule.sessions?[s] = registerSession
        }
        return self.conferenceSchedule
    }

    func unregister(session: Session) -> ConferenceSchedule {
        if let s = self.conferenceSchedule.sessions?.firstIndex(of: session) {
            var registerSession = session
            registerSession.isRegistered = false
            self.conferenceSchedule.sessions?[s] = registerSession
        }
        return self.conferenceSchedule
    }
    
    func register(session: Session) async -> ConferenceSchedule {
        if let s = self.conferenceSchedule.sessions?.firstIndex(of: session) {
            var registerSession = session
            registerSession.isRegistered = true
            self.conferenceSchedule.sessions?[s] = registerSession
        }
        return self.conferenceSchedule
    }

    func unregister(session: Session) async -> ConferenceSchedule {
        if let s = self.conferenceSchedule.sessions?.firstIndex(of: session) {
            var registerSession = session
            registerSession.isRegistered = false
            self.conferenceSchedule.sessions?[s] = registerSession
        }
        return self.conferenceSchedule
    }
}
