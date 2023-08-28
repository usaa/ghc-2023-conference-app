//
//  ConferenceScheduleViewModel.swift
//  Conference
//
//  Created by Pham, Ashley on 8/28/23.
//

import Foundation
import Combine

class ConferenceScheduleViewModel: ObservableObject {
    
    @Published var result: ConferenceScheduleResult = .uninitialized
    var repository: ConferenceScheduleRepository
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        self.repository = ConferenceScheduleRepository()
        self.loadSchedule()
        let result = self.repository.data.map { $0 }
        result
            .receive(on: DispatchQueue.main)
            .sink {
                self.result = $0
            }
            .store(in: &cancellables)
    }
    
    func loadSchedule() {
        self.repository.getSessions()
    }
    
    func addSession(session: Session) {
        self.repository.add(session: session)
    }
    
    func removeSession(session: Session) {
        self.repository.remove(session: session)
    }
    
}

