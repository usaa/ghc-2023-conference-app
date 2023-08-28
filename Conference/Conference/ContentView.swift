//
//  ContentView.swift
//  Conference
//
//  Created by Pham, Ashley on 8/28/23.
//

import SwiftUI

struct ContentView: View {
    
    let service = ConferenceScheduleService()
    let store = ConferenceScheduleDataStore(minutesToLive: 0.5)
    let conferenceScheduleRepository: ConferenceScheduleRepository
    let conferenceScheduleViewModel: ConferenceScheduleViewModel
    let myScheduleViewModel: MyScheduleViewModel
    
    init() {
        self.conferenceScheduleRepository = ConferenceScheduleRepository(service: self.service, store: self.store)
        self.conferenceScheduleViewModel = ConferenceScheduleViewModel(repository: self.conferenceScheduleRepository)
        self.myScheduleViewModel = MyScheduleViewModel(repository: self.conferenceScheduleRepository)
    }
    var body: some View {
        TabView {
            ConferenceScheduleView(viewModel: self.conferenceScheduleViewModel)
                .tabItem{
                    Label("Schedule", systemImage: "calendar.badge.plus")
                }
            MyScheduleView(viewModel: self.myScheduleViewModel)
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
