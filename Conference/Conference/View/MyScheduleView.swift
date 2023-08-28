//
//  MyScheduleView.swift
//  Conference
//
//  Created by Pham, Ashley on 8/29/23.
//

import SwiftUI

struct MyScheduleView: View {
    
    @StateObject var viewModel = MyScheduleViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.conferenceSchedule.sessions!) { session in
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
        }
    }
}

struct MyScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        MyScheduleView()
    }
}
