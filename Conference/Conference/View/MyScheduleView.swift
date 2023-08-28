//
//  MyScheduleView.swift
//  Conference
//
//  Created by Pham, Ashley on 8/29/23.
//

import SwiftUI

struct MyScheduleView: View {
    
    @ObservedObject var viewModel: MyScheduleViewModel
    
    init(viewModel: MyScheduleViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            switch viewModel.result {
            case.success(let conferenceSchedule):
                List {
                    ForEach(conferenceSchedule.sessions!) { session in
                        if session.isRegistered {
                            HStack {
                                Text(session.title)
                                    .font(.headline)
                                Spacer()
                                Text(session.body)
                                    .font(.body)
                            }
                        }
                    }
                }
                .listStyle(.plain)
                .navigationTitle("My Schedule")
                .navigationBarTitleDisplayMode(.large)
                .toolbarBackground(.orange, for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbarColorScheme(.dark, for: .navigationBar)
            case.loading:
                ProgressView()
            case.uninitialized:
                Text("Uninitialized")
            }
        }
    }
}

struct MyScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        MyScheduleView(viewModel: MyScheduleViewModel(repository: ConferenceScheduleRepository(service: ConferenceScheduleService(), store: ConferenceScheduleDataStore())))
    }
}
