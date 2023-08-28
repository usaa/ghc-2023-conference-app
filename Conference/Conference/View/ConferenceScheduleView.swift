//
//  ConferenceScheduleView.swift
//  Conference
//
//  Created by Pham, Ashley on 8/28/23.
//

import SwiftUI

struct ConferenceScheduleView: View {
    
    @StateObject var viewModel = ConferenceScheduleViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.conferenceSchedule.sessions!) { session in
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
        }
    }
}

struct ConferenceSchedule_Previews: PreviewProvider {
    static var previews: some View {
        ConferenceScheduleView()
    }
}
