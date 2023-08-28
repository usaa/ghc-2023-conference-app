//
//  MyScheduleView.swift
//  Conference
//
//  Created by Pham, Ashley on 8/29/23.
//

import SwiftUI

struct MyScheduleView: View {
    
    @ObservedObject var viewModel: MyScheduleViewModel
    
    init(repository: ConferenceScheduleRepository) {
        self.viewModel = MyScheduleViewModel(repository: repository)
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
        MyScheduleView(repository: ConferenceScheduleRepository())
    }
}
