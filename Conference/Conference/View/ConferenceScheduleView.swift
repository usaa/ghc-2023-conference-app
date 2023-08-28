//
//  ConferenceScheduleView.swift
//  Conference
//
//  Created by Pham, Ashley on 8/28/23.
//

import SwiftUI

struct ConferenceScheduleView: View {
    
    @ObservedObject var viewModel: ConferenceScheduleViewModel
    
    init(viewModel: ConferenceScheduleViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            switch viewModel.result {
            case .success(let conferenceSchedule):
                List {
                    ForEach(conferenceSchedule.sessions!) { session in
                        HStack {
                            Text(session.title)
                                .font(.headline)
                            Spacer()
                            Text(session.body)
                                .font(.body)
                            Image(systemName: session.isRegistered ? "star.fill" : "star")
                                .foregroundColor(.teal)
                        }
                        .onTapGesture {
                            if !session.isRegistered {
                                viewModel.addSession(session: session)
                            } else {
                                viewModel.removeSession(session: session)
                            }
                        }
                    }
                }
                .listStyle(.plain)
                .navigationTitle("Conference Schedule")
                .navigationBarTitleDisplayMode(.large)
            case.loading:
                ProgressView()
            case.uninitialized:
                Text("Uninitialized")
            }
        }
    }
}

struct ConferenceSchedule_Previews: PreviewProvider {
    static var previews: some View {
        ConferenceScheduleView(viewModel: ConferenceScheduleViewModel(repository: ConferenceScheduleRepository(service: ConferenceScheduleService(), store: ConferenceScheduleDataStore())))
    }
}
