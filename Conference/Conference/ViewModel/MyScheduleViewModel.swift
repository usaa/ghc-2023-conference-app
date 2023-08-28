//
//  MyScheduleViewModel.swift
//  Conference
//
//  Created by Pham, Ashley on 8/29/23.
//

import Foundation
import Combine

class MyScheduleViewModel: ObservableObject {
    
    @Published var result: ConferenceScheduleResult = .uninitialized
    private var cancellables = Set<AnyCancellable>()
    
    init(repository: ConferenceScheduleRepository) {
        let data = repository.data.map { $0.data }
        data
            .receive(on: DispatchQueue.main)
            .sink {
                self.result = .success(data: $0)
            }
            .store(in: &cancellables)
    }
    
}
