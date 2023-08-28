//
//  ContentView.swift
//  Conference
//
//  Created by Pham, Ashley on 8/28/23.
//

import SwiftUI

struct ContentView: View {
    let conferenceScheduleRepository: ConferenceScheduleRepository = ConferenceScheduleRepository()
    var body: some View {
        TabView {
            ConferenceScheduleView(repository: conferenceScheduleRepository)
                .tabItem{
                    Label("Schedule", systemImage: "calendar.badge.plus")
                }
            MyScheduleView(repository: conferenceScheduleRepository)
                .tabItem{
                    Label("My Schedule", systemImage: "star.fill")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
